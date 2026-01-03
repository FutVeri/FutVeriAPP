import 'api_client.dart';
import '../../models/club.dart';

/// Authentication API service for Club Panel
class AuthApi {
  final ApiClient _client = ApiClient.instance;
  
  /// Login with email and password (for club accounts)
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
  
  /// Get current club user profile
  Future<ClubUserResponse> getCurrentUser() async {
    final response = await _client.get('/auth/me');
    return ClubUserResponse.fromJson(response.data);
  }
  
  /// Logout - clear tokens
  Future<void> logout() async {
    await _client.clearTokens();
  }
  
  /// Check if user is logged in
  bool get isLoggedIn => _client.hasTokens;
  
  /// Initialize - load tokens from storage
  Future<void> initialize() async {
    await _client.initializeTokens();
  }
}

/// Token response from login
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

/// Club user response from /auth/me
class ClubUserResponse {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final String role;
  final bool isActive;
  final bool isVerified;
  final String? clubName;
  final String? clubLogoUrl;
  final String? city;
  final String? country;
  final String? league;
  final DateTime createdAt;
  
  ClubUserResponse({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.role,
    required this.isActive,
    required this.isVerified,
    this.clubName,
    this.clubLogoUrl,
    this.city,
    this.country,
    this.league,
    required this.createdAt,
  });
  
  factory ClubUserResponse.fromJson(Map<String, dynamic> json) {
    return ClubUserResponse(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String,
      isActive: json['is_active'] as bool,
      isVerified: json['is_verified'] as bool,
      clubName: json['club_name'] as String?,
      clubLogoUrl: json['club_logo_url'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      league: json['league'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
  
  /// Convert to Club model
  Club toClub() {
    return Club(
      id: id,
      name: clubName ?? name,
      email: email,
      logoUrl: clubLogoUrl ?? avatarUrl,
      city: city,
      country: country,
      league: league,
      createdAt: createdAt,
    );
  }
}
