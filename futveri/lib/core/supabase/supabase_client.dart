import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase client wrapper for easy access throughout the app
class SupabaseClientWrapper {
  SupabaseClientWrapper._();
  
  static final SupabaseClientWrapper _instance = SupabaseClientWrapper._();
  static SupabaseClientWrapper get instance => _instance;
  
  /// Get the Supabase client instance
  SupabaseClient get client => Supabase.instance.client;
  
  /// Get auth instance
  GoTrueClient get auth => client.auth;
  
  /// Get current user
  User? get currentUser => auth.currentUser;
  
  /// Get current session
  Session? get currentSession => auth.currentSession;
  
  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;
  
  /// Get access token
  String? get accessToken => currentSession?.accessToken;
}

/// Global Supabase client instance
final supabase = SupabaseClientWrapper.instance;
