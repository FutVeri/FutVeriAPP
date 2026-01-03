import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_client.dart';
import '../../models/club.dart';

/// Auth state for Club Panel using Supabase
class ClubAuthState {
  final User? user;
  final Club? currentClub;
  final bool isLoading;
  final String? errorMessage;

  const ClubAuthState({
    this.user,
    this.currentClub,
    this.isLoading = false,
    this.errorMessage,
  });

  bool get isAuthenticated => user != null && currentClub != null;

  ClubAuthState copyWith({
    User? user,
    Club? currentClub,
    bool? isLoading,
    String? errorMessage,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return ClubAuthState(
      user: clearUser ? null : (user ?? this.user),
      currentClub: clearUser ? null : (currentClub ?? this.currentClub),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Club Panel Auth Notifier with Supabase
class ClubAuthNotifier extends Notifier<ClubAuthState> {
  @override
  ClubAuthState build() {
    // Listen to auth state changes
    supabase.auth.onAuthStateChange.listen((data) {
      final user = data.session?.user;
      if (user != null) {
        _loadClubProfile(user);
      } else {
        state = const ClubAuthState();
      }
    });
    
    // Check initial auth state
    final currentUser = supabase.currentUser;
    if (currentUser != null) {
      _loadClubProfile(currentUser);
    }
    
    return const ClubAuthState();
  }
  
  /// Load club profile from database
  Future<void> _loadClubProfile(User user) async {
    try {
      final response = await supabase.client
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();
      
      if (response != null) {
        final role = response['role'] as String?;
        
        // Check if user has club or admin role
        if (role != 'club' && role != 'admin' && role != 'superadmin') {
          state = state.copyWith(
            isLoading: false,
            errorMessage: 'Bu hesap kulüp paneli için yetkilendirilmemiş',
          );
          await supabase.auth.signOut();
          return;
        }
        
        state = state.copyWith(
          user: user,
          currentClub: Club(
            id: response['id'] as String,
            name: response['club_name'] as String? ?? response['name'] as String,
            email: response['email'] as String,
            logoUrl: response['avatar_url'] as String?,
            city: response['city'] as String?,
            country: response['country'] as String?,
            league: response['league'] as String?,
            createdAt: DateTime.parse(response['created_at'] as String),
          ),
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          user: user,
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        user: user,
        isLoading: false,
      );
    }
  }

  /// Sign in with email and password (for club accounts)
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        await _loadClubProfile(response.user!);
        return state.isAuthenticated;
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

  /// Sign out
  Future<void> logout() async {
    await supabase.auth.signOut();
    state = const ClubAuthState();
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
    return message;
  }
}

/// Club Auth Provider
final clubAuthProvider = NotifierProvider<ClubAuthNotifier, ClubAuthState>(() {
  return ClubAuthNotifier();
});
