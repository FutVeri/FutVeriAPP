import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../core/constants/app_constants.dart';

/// Auth state
class AuthState {
  final Admin? currentAdmin;
  final bool isLoading;
  final String? errorMessage;

  const AuthState({
    this.currentAdmin,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isAuthenticated => currentAdmin != null;

  AuthState copyWith({
    Admin? currentAdmin,
    bool? isLoading,
    String? errorMessage,
    bool clearAdmin = false,
    bool clearError = false,
  }) {
    return AuthState(
      currentAdmin: clearAdmin ? null : (currentAdmin ?? this.currentAdmin),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Auth notifier
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (username == AppConstants.adminUsername &&
        password == AppConstants.adminPassword) {
      state = state.copyWith(
        currentAdmin: Admin(
          id: 'admin1',
          username: username,
          name: 'Admin User',
          role: 'admin',
          createdAt: DateTime.now().subtract(const Duration(days: 365)),
        ),
        isLoading: false,
      );
      return true;
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Geçersiz kullanıcı adı veya şifre',
      );
      return false;
    }
  }

  void logout() {
    state = const AuthState();
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

/// Auth provider
final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
