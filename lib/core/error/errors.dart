abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  String toString() => 'Failure: $message';
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {int? statusCode})
    : super(message, statusCode: statusCode);
}

class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}
