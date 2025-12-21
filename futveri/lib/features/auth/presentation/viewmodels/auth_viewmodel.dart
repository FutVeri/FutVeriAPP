import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;
  final bool isLoginMode;

  AuthState({
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
    this.isLoginMode = true,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
    bool? isLoginMode,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoginMode: isLoginMode ?? this.isLoginMode,
    );
  }
}

class AuthViewModel extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState();
  }

  void toggleMode() {
    state = state.copyWith(isLoginMode: !state.isLoginMode);
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (email.isNotEmpty && password.length >= 6) {
      state = state.copyWith(isLoading: false, isAuthenticated: true);
      return true;
    } else {
      state = state.copyWith(
        isLoading: false, 
        error: 'Invalid email or password (min 6 chars)'
      );
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (name.isNotEmpty && email.isNotEmpty && password.length >= 6) {
      state = state.copyWith(isLoading: false, isAuthenticated: true);
      return true;
    } else {
      state = state.copyWith(
        isLoading: false, 
        error: 'Please fill all fields correctly'
      );
      return false;
    }
  }

  void logout() {
    state = AuthState();
  }
}

final authProvider = NotifierProvider<AuthViewModel, AuthState>(() {
  return AuthViewModel();
});
