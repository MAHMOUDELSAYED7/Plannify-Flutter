import 'package:dio/dio.dart';

import 'app_exceptions.dart';
import 'failure.dart';

class ErrorHandler {
  static Failure handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is CacheException) {
      return CacheFailure(error.message);
    } else {
      return ServerFailure(error.toString());
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkFailure('Connection timeout');
      case DioExceptionType.badResponse:
        return ServerFailure(
          error.response?.data['message'] ?? 'Server error',
          error.response?.statusCode,
        );
      default:
        return NetworkFailure('Network error');
    }
  }
}