/// API configuration and constants
class ApiConfig {
  // Development
  static const String devBaseUrl = 'http://localhost:8000/api/v1';
  
  // Production - Update this when deploying
  static const String prodBaseUrl = 'https://your-production-url.com/api/v1';
  
  // Current environment
  static const bool isProduction = false;
  
  /// Get the appropriate base URL based on environment
  static String get baseUrl => isProduction ? prodBaseUrl : devBaseUrl;
  
  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Endpoints
  static const String authRegister = '/auth/register';
  static const String authRegisterClub = '/auth/register/club';
  static const String authLogin = '/auth/login';
  static const String authRefresh = '/auth/refresh';
  static const String authMe = '/auth/me';
  static const String authChangePassword = '/auth/change-password';
  
  static const String users = '/users';
  static const String usersStats = '/users/stats';
  
  static const String reports = '/reports';
  static const String reportsStats = '/reports/stats';
  
  static const String players = '/players';
  static const String teams = '/teams';
  
  static const String dashboard = '/dashboard';
  static const String dashboardStats = '/dashboard/stats';
  static const String dashboardPending = '/dashboard/pending';
  static const String dashboardActivity = '/dashboard/recent-activity';
}
