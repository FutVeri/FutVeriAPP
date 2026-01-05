import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futveri/core/supabase/supabase_auth_service.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;
  final bool isLoginMode;
  final String? userName;
  final String? userEmail;
  final String? userRole;
  final Map<String, dynamic>? userProfile;

  AuthState({
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
    this.isLoginMode = true,
    this.userName,
    this.userEmail,
    this.userRole,
    this.userProfile,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
    bool? isLoginMode,
    String? userName,
    String? userEmail,
    String? userRole,
    Map<String, dynamic>? userProfile,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoginMode: isLoginMode ?? this.isLoginMode,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userRole: userRole ?? this.userRole,
      userProfile: userProfile ?? this.userProfile,
    );
  }
}

class AuthViewModel extends Notifier<AuthState> {
  @override
  AuthState build() {
    // Watch Supabase auth state
    final supabaseAuth = ref.watch(supabaseAuthProvider);
    
    return AuthState(
      isAuthenticated: supabaseAuth.isAuthenticated,
      userName: supabaseAuth.userName,
      userEmail: supabaseAuth.user?.email,
      userRole: supabaseAuth.userRole,
      userProfile: supabaseAuth.userProfile,
      isLoading: supabaseAuth.isLoading,
      error: supabaseAuth.errorMessage,
    );
  }

  void toggleMode() {
    state = state.copyWith(isLoginMode: !state.isLoginMode);
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final authNotifier = ref.read(supabaseAuthProvider.notifier);
      final success = await authNotifier.signIn(email, password);
      
      if (success) {
        state = state.copyWith(isLoading: false, isAuthenticated: true);
        return true;
      } else {
        final authState = ref.read(supabaseAuthProvider);
        state = state.copyWith(
          isLoading: false, 
          error: authState.errorMessage ?? 'Giriş başarısız'
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        error: 'Bağlantı hatası: $e'
      );
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final authNotifier = ref.read(supabaseAuthProvider.notifier);
      final success = await authNotifier.signUp(email, password, name);
      
      if (success) {
        state = state.copyWith(isLoading: false, isAuthenticated: true);
        return true;
      } else {
        final authState = ref.read(supabaseAuthProvider);
        state = state.copyWith(
          isLoading: false, 
          error: authState.errorMessage ?? 'Kayıt başarısız'
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        error: 'Bağlantı hatası: $e'
      );
      return false;
    }
  }

  Future<void> logout() async {
    final authNotifier = ref.read(supabaseAuthProvider.notifier);
    await authNotifier.signOut();
    state = AuthState();
  }
}

final authProvider = NotifierProvider<AuthViewModel, AuthState>(() {
  return AuthViewModel();
});
