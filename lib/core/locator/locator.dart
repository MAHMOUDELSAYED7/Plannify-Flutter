import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:plannify/presentation/cubit/auth/auth_status/auth_status_cubit.dart';
import 'package:plannify/presentation/cubit/auth/forgot_password/forgot_password_cubit.dart';
import 'package:plannify/presentation/cubit/auth/register/register_cubit.dart';
import 'package:plannify/presentation/cubit/auth/verify_otp/verify_otp_cubit.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/source/auth_remote_data_source.dart';

import '../../presentation/cubit/auth/login/login_cubit.dart';
import '../../presentation/cubit/auth/reset_password/reset_password_cubit.dart';
import '../../presentation/cubit/onboarding/onboarding_cubit.dart';

import '../network/dio_client.dart';
import '../security/secure_storage_repository.dart';
import '../utils/formatters/form_validation.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerSingleton(Dio());

  sl.registerLazySingleton(() => DioClient(sl<Dio>()));
  sl.registerLazySingleton(
    () => AuthRemoteDataSourceImpl(dioClient: sl<DioClient>()),
  );

  sl.registerLazySingleton(() => SecureStorageManager());
  sl.registerSingleton(InternetConnectionChecker.createInstance());

  sl.registerLazySingleton(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSourceImpl>(),
      secureStorage: sl<SecureStorageManager>(),
      connectionChecker: sl<InternetConnectionChecker>(),
    ),
  );

  sl.registerLazySingleton(() => FormValidationManager());

  // Cubits
  sl.registerFactory(() => OnboardingCubit());
  sl.registerFactory(() => LoginCubit(sl<AuthRepositoryImpl>()));
  sl.registerFactory(() => RegisterCubit(sl<AuthRepositoryImpl>()));
  sl.registerFactory(() => ForgotPasswordCubit(sl<AuthRepositoryImpl>()));
  sl.registerFactory(() => VerifyOtpCubit(sl<AuthRepositoryImpl>()));
  sl.registerFactory(() => ResetPasswordCubit(sl<AuthRepositoryImpl>()));
  sl.registerFactory(() => AuthStatusCubit(sl<SecureStorageManager>()));
}
