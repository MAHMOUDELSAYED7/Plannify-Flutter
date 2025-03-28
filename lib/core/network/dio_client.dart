import 'package:dio/dio.dart';

import '../errors/app_exceptions.dart';
import 'api_endpoints.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );

    _dio.interceptors.addAll([LoggingInterceptor(), AuthInterceptor()]);
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioException catch (err) {
      throw NetworkException(
        err.response?.data['message'] ?? 'Network error',
        err.response?.statusCode,
      );
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (err) {
      throw NetworkException(
        err.response?.data['message'] ?? 'Network error',
        err.response?.statusCode,
      );
    }
  }

  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await _dio.patch(path, data: data);
    } on DioException catch (err) {
      throw NetworkException(
        err.response?.data['message'] ?? 'Network error',
        err.response?.statusCode,
      );
    }
  }

  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } on DioException catch (err) {
      throw NetworkException(
        err.response?.data['message'] ?? 'Network error',
        err.response?.statusCode,
      );
    }
  }
}
