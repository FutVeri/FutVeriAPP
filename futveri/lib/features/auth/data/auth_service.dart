import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api.dart';
import '../domain/user.dart';

/// Auth state
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;
}

/// Auth repository
class AuthRepository {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  AuthRepository(this._dio, this._storage);

  /// Login with email and password
  Future<User> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiConfig.authLogin,
        data: {'email': email, 'password': password},
      );

      final tokens = AuthTokens.fromJson(response.data);
      
      // Save tokens
      await _storage.write(
        key: TokenKeys.accessToken,
        value: tokens.accessToken,
      );
      await _storage.write(
        key: TokenKeys.refreshToken,
        value: tokens.refreshToken,
      );

      // Get user info
      return await getCurrentUser();
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// Register new user
  Future<User> register({
    required String email,
    required String password,
    required String name,
    String role = 'user',
    String? region,
  }) async {
    try {
      final response = await _dio.post(
        ApiConfig.authRegister,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'role': role,
          if (region != null) 'region': region,
        },
      );

      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// Get current authenticated user
  Future<User> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiConfig.authMe);
      return User.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  /// Logout - clear tokens
  Future<void> logout() async {
    await _storage.delete(key: TokenKeys.accessToken);
    await _storage.delete(key: TokenKeys.refreshToken);
  }

  /// Check if user is logged in (has tokens)
  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: TokenKeys.accessToken);
    return token != null;
  }

  /// Change password
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _dio.post(
        ApiConfig.authChangePassword,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

/// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(dioProvider);
  final storage = ref.read(secureStorageProvider);
  return AuthRepository(dio, storage);
});

/// Auth state notifier - using Notifier for Riverpod 3.x
class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.read(authRepositoryProvider);
    // Check auth status on init
    _checkAuthStatus();
    return const AuthState();
  }

  Future<void> _checkAuthStatus() async {
    try {
      final isLoggedIn = await _repository.isLoggedIn();
      if (isLoggedIn) {
        state = state.copyWith(status: AuthStatus.loading);
        final user = await _repository.getCurrentUser();
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: user,
        );
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    try {
      final user = await _repository.login(email, password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      );
    } on ApiException catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Bir hata oluştu',
      );
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    String role = 'user',
    String? region,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, errorMessage: null);

    try {
      await _repository.register(
        email: email,
        password: password,
        name: name,
        role: role,
        region: region,
      );
      // After registration, login automatically
      await login(email, password);
    } on ApiException catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Bir hata oluştu',
      );
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> refreshUser() async {
    try {
      final user = await _repository.getCurrentUser();
      state = state.copyWith(user: user);
    } catch (e) {
      // Ignore refresh errors
    }
  }
}

/// Auth state provider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

/// Current user provider (convenience)
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authProvider).user;
});

/// Is authenticated provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});
