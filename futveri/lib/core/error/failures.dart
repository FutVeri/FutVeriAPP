import 'package:dartz/dartz.dart';

/// Result type for error handling
/// Success: Right(T)
/// Failure: Left(Failure)
typedef Result<T> = Either<Failure, T>;

/// Base class for all failures in the application
abstract class Failure {
  final String message;
  final String? code;
  final dynamic originalError;

  const Failure({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

/// Server-related failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Cache-related failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Network-related failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// AI service failures
class AiFailure extends Failure {
  const AiFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Simulation failures
class SimulationFailure extends Failure {
  const SimulationFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Generic unexpected failures
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    required super.message,
    super.code,
    super.originalError,
  });
}
