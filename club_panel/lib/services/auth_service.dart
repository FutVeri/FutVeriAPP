import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/club.dart';
import '../core/constants/app_constants.dart';

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

/// Auth notifier
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, clearError: true);

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    if (email == AppConstants.clubEmail &&
        password == AppConstants.clubPassword) {
      state = state.copyWith(
        currentClub: Club(
          id: 'club1',
          name: 'Galatasaray SK',
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
