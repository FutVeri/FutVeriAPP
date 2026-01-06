import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_client.dart';

/// Auth state for Supabase authentication
class SupabaseAuthState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic>? userProfile;

  const SupabaseAuthState({
    this.user,
    this.isLoading = false,
    this.errorMessage,
    this.userProfile,
  });

  bool get isAuthenticated => user != null;
  
  String get userName => userProfile?['name'] ?? user?.email ?? 'User';
  String? get userRole => userProfile?['role'] as String?;
  String? get avatarUrl => userProfile?['avatar_url'] as String?;

  SupabaseAuthState copyWith({
    User? user,
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? userProfile,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return SupabaseAuthState(
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      userProfile: clearUser ? null : (userProfile ?? this.userProfile),
    );
  }
}

/// Supabase Auth Notifier with Riverpod
class SupabaseAuthNotifier extends Notifier<SupabaseAuthState> {
  @override
  SupabaseAuthState build() {
    // Listen to auth state changes
    supabase.auth.onAuthStateChange.listen((data) {
      final user = data.session?.user;
      if (user != null) {
        _loadUserProfile(user);
      } else {
        state = const SupabaseAuthState();
      }
    });
    
    // Check initial auth state
    final currentUser = supabase.currentUser;
    if (currentUser != null) {
      _loadUserProfile(currentUser);
    }
    
    return const SupabaseAuthState();
  }
  
  /// Load user profile from database
  Future<void> _loadUserProfile(User user) async {
    try {
      final response = await supabase.client
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      
      state = state.copyWith(
        user: user,
        userProfile: response,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        user: user,
        isLoading: false,
      );
    }
  }

  /// Sign in with email and password
  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        await _loadUserProfile(response.user!);
        return true;
      }
      
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Giriş başarısız',
      );
      return false;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getLocalizedError(e.message),
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Bağlantı hatası: $e',
      );
      return false;
    }
  }

  /// Sign up with email and password
  Future<bool> signUp(String email, String password, String name) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      print('🔐 Starting signup for: $email');
      
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      
      print('🔐 Auth signUp response user: ${response.user?.id}');
      print('🔐 Auth signUp response session: ${response.session?.accessToken != null}');
      
      if (response.user != null) {
        // Create user profile in database with ALL required fields
        try {
          print('📝 Creating user profile in users table...');
          await supabase.client.from('users').insert({
            'id': response.user!.id,
            'email': email,
            'name': name,
            'role': 'scout',
            'is_active': true,
            'is_verified': false,
            'hashed_password': '', // Empty - Supabase Auth manages passwords
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          });
          print('✅ User profile created successfully');
        } catch (insertError) {
          print('❌ Error inserting user profile: $insertError');
          // User is created in Auth but profile insert failed
        }
        
        state = state.copyWith(
          user: response.user,
          isLoading: false,
        );
        return true;
      }
      
      print('❌ Auth returned null user');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Kayıt başarısız - lütfen tekrar deneyin',
      );
      return false;
    } on AuthException catch (e) {
      print('❌ AuthException: ${e.message}');
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getLocalizedError(e.message),
      );
      return false;
    } catch (e) {
      print('❌ General signup error: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Bağlantı hatası: $e',
      );
      return false;
    }
  }


  /// Refresh user profile from database
  Future<void> refreshProfile() async {
    final user = supabase.currentUser;
    if (user != null) {
      await _loadUserProfile(user);
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await supabase.auth.signOut();
    state = const SupabaseAuthState();
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(clearError: true);
  }
  
  /// Get localized error message
  String _getLocalizedError(String message) {
    if (message.contains('Invalid login credentials')) {
      return 'Geçersiz e-posta veya şifre';
    }
    if (message.contains('Email not confirmed')) {
      return 'E-posta adresinizi doğrulayın';
    }
    if (message.contains('User already registered')) {
      return 'Bu e-posta zaten kayıtlı';
    }
    return message;
  }
}

/// Supabase Auth Provider
final supabaseAuthProvider = NotifierProvider<SupabaseAuthNotifier, SupabaseAuthState>(() {
  return SupabaseAuthNotifier();
});
