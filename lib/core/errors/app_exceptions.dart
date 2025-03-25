class AppException implements Exception {
  final String message;
  final int? statusCode;

  AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(super.message, [super.statusCode]);
}

class CacheException extends AppException {
  CacheException(super.message);
}

class ValidationException extends AppException {
  ValidationException(super.message);
}
