/// Base class for all exceptions
class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: $message${code != null ? ' (code: $code)' : ''}';
}

/// Server exceptions
class ServerException extends AppException {
  ServerException(super.message, [super.code]);
}

/// Cache exceptions
class CacheException extends AppException {
  CacheException(super.message, [super.code]);
}

/// Network exceptions
class NetworkException extends AppException {
  NetworkException(super.message, [super.code]);
}

/// Validation exceptions
class ValidationException extends AppException {
  ValidationException(super.message, [super.code]);
}

/// AI service exceptions
class AiException extends AppException {
  AiException(super.message, [super.code]);
}
