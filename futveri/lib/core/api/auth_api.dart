import 'package:dio/dio.dart';
import 'api_client.dart';

/// Authentication API service
class AuthApi {
  final ApiClient _client = ApiClient.instance;
  
  /// Login with email and password
  /// Returns token response on success
  Future<AuthResponse> login(String email, String password) async {
    final response = await _client.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    
    final authResponse = AuthResponse.fromJson(response.data);
    await _client.setTokens(authResponse.accessToken, authResponse.refreshToken);
    return authResponse;
  }
  
  /// Register a new user
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String name,
    String role = 'user',
    String? region,
  }) async {
    final response = await _client.post(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
        'role': role,
        if (region != null) 'region': region,
      },
    );
    
    final authResponse = AuthResponse.fromJson(response.data);
    await _client.setTokens(authResponse.accessToken, authResponse.refreshToken);
    return authResponse;
  }
  
  /// Get current user profile
  Future<UserResponse> getCurrentUser() async {
    final response = await _client.get('/auth/me');
    return UserResponse.fromJson(response.data);
  }
  
  /// Logout - clear tokens
  Future<void> logout() async {
    await _client.clearTokens();
  }
  
  /// Check if user is logged in
  bool get isLoggedIn => _client.hasTokens;
}

/// Token response from login/register
class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  
  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType = 'bearer',
  });
  
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String? ?? 'bearer',
    );
  }
}

/// User response from /auth/me
class UserResponse {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final String role;
  final bool isActive;
  final bool isVerified;
  final String? region;
  final String? clubName;
  final String? city;
  final String? country;
  final String? league;
  final DateTime createdAt;
  
  UserResponse({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.role,
    required this.isActive,
    required this.isVerified,
    this.region,
    this.clubName,
    this.city,
    this.country,
    this.league,
    required this.createdAt,
  });
  
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String,
      isActive: json['is_active'] as bool,
      isVerified: json['is_verified'] as bool,
      region: json['region'] as String?,
      clubName: json['club_name'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      league: json['league'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
