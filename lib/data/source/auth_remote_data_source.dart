import 'package:dio/dio.dart';
import 'package:plannify/core/network/api_endpoints.dart';
import 'package:plannify/core/network/dio_client.dart';

import '../models/auth_model.dart';

abstract interface class IAuthRemoteDataSource {
  Future<Response> login(LoginRequest request);
  Future<Response> register(RegisterRequest request);
  Future<Response> verifyOtp(VerifyOtpRequest request);
  Future<Response> forgotPassword(ForgotPasswordRequest request);
  Future<Response> resetPassword(ResetPasswordRequest request);
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  @override
  Future<Response> login(LoginRequest request) async {
    return _dioClient.post(ApiEndpoints.login, data: request.toJson());
  }

  @override
  Future<Response> register(RegisterRequest request) async {
    return _dioClient.post(ApiEndpoints.register, data: request.toJson());
  }

  @override
  Future<Response> verifyOtp(VerifyOtpRequest request) async {
    return _dioClient.post(ApiEndpoints.verifyOtp, data: request.toJson());
  }

  @override
  Future<Response> forgotPassword(ForgotPasswordRequest request) async {
    return _dioClient.post(ApiEndpoints.forgotPassword, data: request.toJson());
  }

  @override
  Future<Response> resetPassword(ResetPasswordRequest request) async {
    return _dioClient.post(ApiEndpoints.resetPassword, data: request.toJson());
  }
}
