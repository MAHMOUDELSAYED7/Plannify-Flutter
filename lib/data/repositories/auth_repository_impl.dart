import 'package:fpdart/fpdart.dart';
import 'package:plannify/core/errors/failure.dart';
import 'package:plannify/core/security/secure_storage_repository.dart';

import '../../core/errors/app_exceptions.dart';
import '../models/auth_model.dart';
import '../source/auth_remote_data_source.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, AuthResponse>> login(LoginRequest request);
  Future<Either<Failure, AuthResponse>> register(RegisterRequest request);
  Future<Either<Failure, AuthResponse>> verifyOtp(VerifyOtpRequest request);
  Future<Either<Failure, AuthResponse>> forgotPassword(
    ForgotPasswordRequest request,
  );
  Future<Either<Failure, AuthResponse>> resetPassword(
    ResetPasswordRequest request,
  );

  Future<Either<Failure, void>> logout();
}

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource _remoteDataSource;
  final SecureStorageManager _secureStorage;
  final InternetConnectionChecker _connectionChecker;

  AuthRepositoryImpl({
    required IAuthRemoteDataSource remoteDataSource,
    required SecureStorageManager secureStorage,
    required InternetConnectionChecker connectionChecker,
  }) : _remoteDataSource = remoteDataSource,
       _secureStorage = secureStorage,
       _connectionChecker = connectionChecker;

  @override
  Future<Either<Failure, AuthResponse>> login(LoginRequest request) async {
    try {
      if (!await _connectionChecker.hasConnection) {
        return Left(NetworkFailure('No internet connection'));
      }

      final response = await _remoteDataSource.login(request);
      final authResponse = AuthResponse.fromJson(response.data);

      await _secureStorage.saveAuthToken(authResponse.token!);
      return Right(authResponse);
    } on NetworkException catch (err) {
      return Left(NetworkFailure(err.message, err.statusCode));
    } catch (err) {
      return Left(ServerFailure('Login failed'));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> register(
    RegisterRequest request,
  ) async {
    try {
      if (!await _connectionChecker.hasConnection) {
        return Left(NetworkFailure('No internet connection'));
      }

      final response = await _remoteDataSource.register(request);
      final authResponse = AuthResponse.fromJson(response.data);
      return Right(authResponse);
    } on NetworkException catch (err) {
      return Left(NetworkFailure(err.message, err.statusCode));
    } catch (err) {
      return Left(ServerFailure('Registration failed'));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> verifyOtp(
    VerifyOtpRequest request,
  ) async {
    try {
      if (!await _connectionChecker.hasConnection) {
        return Left(NetworkFailure('No internet connection'));
      }

      final response = await _remoteDataSource.verifyOtp(request);
      final authResponse = AuthResponse.fromJson(response.data);
      return Right(authResponse);
    } on NetworkException catch (err) {
      return Left(NetworkFailure(err.message, err.statusCode));
    } catch (err) {
      return Left(ServerFailure('OTP verification failed'));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    try {
      if (!await _connectionChecker.hasConnection) {
        return Left(NetworkFailure('No internet connection'));
      }

      final response = await _remoteDataSource.forgotPassword(request);
      final authResponse = AuthResponse.fromJson(response.data);
      return Right(authResponse);
    } on NetworkException catch (err) {
      return Left(NetworkFailure(err.message, err.statusCode));
    } catch (err) {
      return Left(ServerFailure('Password reset failed'));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      if (!await _connectionChecker.hasConnection) {
        return Left(NetworkFailure('No internet connection'));
      }

      final response = await _remoteDataSource.resetPassword(request);
      final authResponse = AuthResponse.fromJson(response.data);
      return Right(authResponse);
    } on NetworkException catch (err) {
      return Left(NetworkFailure(err.message, err.statusCode));
    } catch (err) {
      return Left(ServerFailure('Password reset failed'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _secureStorage.clearUserData();
      return const Right(null);
    } catch (err) {
      return Left(CacheFailure('Logout failed'));
    }
  }
}
