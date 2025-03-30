import 'package:dio/dio.dart';
import 'package:plannify/core/locator/locator.dart';

import '../../security/secure_storage_repository.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    sl<SecureStorageManager>()
        .getAuthToken()
        .then((token) {
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          super.onRequest(options, handler);
        })
        .catchError((error) {
          handler.reject(
            DioException(
              requestOptions: options,
              type: DioExceptionType.badCertificate,
              error: 'Failed to retrieve token: $error',
            ),
          );
        });
  }
}
