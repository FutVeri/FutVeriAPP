import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/club.dart';
import '../core/constants/app_constants.dart';
import '../core/api/auth_api.dart';
import '../core/api/api_config.dart';

/// Auth state
class AuthState {
  final Club? currentClub;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.currentClub,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isAuthenticated => currentClub != null;

  AuthState copyWith({
    Club? currentClub,
    bool? isLoading,
    String? errorMessage,
    bool clearClub = false,
    bool clearError = false,
  }) {
    return AuthState(
      currentClub: clearClub ? null : (currentClub ?? this.currentClub),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Auth notifier with real API integration and mock fallback
class AuthNotifier extends Notifier<AuthState> {
  final AuthApi _authApi = AuthApi();
  
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    // Try real API first
    try {
      final authResponse = await _authApi.login(email, password);
      final userResponse = await _authApi.getCurrentUser();
      
      // Check if user has club role
      if (userResponse.role != 'club' && userResponse.role != 'admin' && userResponse.role != 'superadmin') {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Bu hesap kulüp paneli için yetkilendirilmemiş',
        );
        return false;
      }
      
      state = state.copyWith(
        currentClub: userResponse.toClub(),
        isLoading: false,
      );
      return true;
    } catch (e) {
      // Fallback to mock data if API fails and fallback is enabled
      if (ApiConfig.useMockDataFallback) {
        return _loginWithMockData(email, password);
      }
      
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Bağlantı hatası: ${e.toString()}',
      );
      return false;
    }
  }
  
  /// Fallback to mock login when API is unavailable
  Future<bool> _loginWithMockData(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (email == AppConstants.clubEmail &&
        password == AppConstants.clubPassword) {
      state = state.copyWith(
        currentClub: Club(
          id: 'club1',
          name: 'Ümraniye SK',
          email: email,
          city: 'İstanbul',
          country: 'Türkiye',
          league: 'Süper Lig',
          createdAt: DateTime.now().subtract(const Duration(days: 365)),
        ),
        isLoading: false,
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Geçersiz e-posta veya şifre',
      );
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _authApi.logout();
    } catch (e) {
      // Ignore logout errors
    }
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
  
  /// Initialize auth state on app startup
  Future<void> initialize() async {
    try {
      await _authApi.initialize();
      if (_authApi.isLoggedIn) {
        final userResponse = await _authApi.getCurrentUser();
        state = state.copyWith(
          currentClub: userResponse.toClub(),
        );
      }
    } catch (e) {
      // Ignore initialization errors
    }
  }
}

/// Auth provider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
