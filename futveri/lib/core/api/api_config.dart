/// API configuration for FutVeri mobile app
class ApiConfig {
  /// Base URL for the API
  /// Change this to your production URL when deploying
  static const String baseUrl = 'http://localhost:8000/api/v1';
  
  /// Request timeout duration
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  /// Whether to use mock data when API is unavailable
  static bool useMockDataFallback = true;
  
  /// Storage keys
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
}
