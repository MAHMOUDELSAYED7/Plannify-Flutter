import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:plannify/presentation/viewmodel/onboarding_viewmodel.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/source/auth_remote_data_source.dart';

import '../../presentation/cubit/auth/login/login_cubit.dart';
import '../../presentation/cubit/onboarding/onboarding_cubit.dart';
import '../../presentation/viewmodel/login_viewmodel.dart';
import '../../presentation/viewmodel/splash_viewmodel.dart';
import '../network/dio_client.dart';
import '../security/secure_storage_repository.dart';
import '../utils/formatters/form_validation.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton(Dio());

  locator.registerLazySingleton(() => DioClient(locator<Dio>()));
  locator.registerLazySingleton(
    () => AuthRemoteDataSourceImpl(dioClient: locator<DioClient>()),
  );

  locator.registerLazySingleton(() => SecureStorageManager());
  locator.registerSingleton(InternetConnectionChecker.createInstance());

  locator.registerLazySingleton(
    () => AuthRepositoryImpl(
      remoteDataSource: locator<AuthRemoteDataSourceImpl>(),
      secureStorage: locator<SecureStorageManager>(),
      connectionChecker: locator<InternetConnectionChecker>(),
    ),
  );

  locator.registerLazySingleton(() => FormValidationManager());

  // ViewModels
  locator.registerLazySingleton(() => SplashViewModel());
  locator.registerLazySingleton(() => OnboardingViewModel());
  locator.registerLazySingleton(() => LoginViewModel());

  // Cubits
  locator.registerFactory(() => OnboardingCubit());
  locator.registerFactory(() => LoginCubit(locator<AuthRepositoryImpl>()));
}
