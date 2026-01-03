import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api_config.dart';

export 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Token storage keys
class TokenKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
}

/// Secure storage provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
});

/// Dio client provider with authentication interceptor
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      headers: ApiConfig.defaultHeaders,
    ),
  );

  // Add auth interceptor
  dio.interceptors.add(AuthInterceptor(ref));
  
  // Add logging in debug mode
  if (!ApiConfig.isProduction) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (o) => print('🌐 API: $o'),
    ));
  }

  return dio;
});

/// Authentication interceptor for automatic token handling
class AuthInterceptor extends Interceptor {
  final Ref _ref;

  AuthInterceptor(this._ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth header for public endpoints
    final publicEndpoints = [
      ApiConfig.authLogin,
      ApiConfig.authRegister,
      ApiConfig.authRegisterClub,
    ];

    final isPublic = publicEndpoints.any(
      (endpoint) => options.path.contains(endpoint),
    );

    if (!isPublic) {
      final storage = _ref.read(secureStorageProvider);
      final token = await storage.read(key: TokenKeys.accessToken);
      
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 errors - try to refresh token
    if (err.response?.statusCode == 401) {
      final refreshed = await _tryRefreshToken();
      
      if (refreshed) {
        // Retry the original request
        try {
          final storage = _ref.read(secureStorageProvider);
          final token = await storage.read(key: TokenKeys.accessToken);
          
          final opts = err.requestOptions;
          opts.headers['Authorization'] = 'Bearer $token';
          
          final dio = _ref.read(dioProvider);
          final response = await dio.fetch(opts);
          return handler.resolve(response);
        } catch (e) {
          // If retry fails, continue with error
        }
      }
    }

    handler.next(err);
  }

  Future<bool> _tryRefreshToken() async {
    try {
      final storage = _ref.read(secureStorageProvider);
      final refreshToken = await storage.read(key: TokenKeys.refreshToken);
      
      if (refreshToken == null) return false;

      // Create a new Dio instance to avoid interceptor loop
      final dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          headers: ApiConfig.defaultHeaders,
        ),
      );

      final response = await dio.post(
        ApiConfig.authRefresh,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        await storage.write(
          key: TokenKeys.accessToken,
          value: data['access_token'],
        );
        await storage.write(
          key: TokenKeys.refreshToken,
          value: data['refresh_token'],
        );
        return true;
      }
    } catch (e) {
      // Refresh failed
    }
    
    return false;
  }
}

/// API exception class
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  factory ApiException.fromDioError(DioException error) {
    String message = 'Bir hata oluştu';
    
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Bağlantı zaman aşımı. Lütfen tekrar deneyin.';
        break;
      case DioExceptionType.connectionError:
        message = 'İnternet bağlantınızı kontrol edin.';
        break;
      case DioExceptionType.badResponse:
        final data = error.response?.data;
        if (data is Map && data.containsKey('detail')) {
          message = data['detail'];
        } else {
          message = 'Sunucu hatası (${error.response?.statusCode})';
        }
        break;
      default:
        message = error.message ?? 'Bilinmeyen hata';
    }

    return ApiException(
      message: message,
      statusCode: error.response?.statusCode,
      data: error.response?.data,
    );
  }

  @override
  String toString() => message;
}
