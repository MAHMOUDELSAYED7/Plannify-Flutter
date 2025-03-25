import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton(Dio());

  locator.registerLazySingleton(() => DioClient(locator<Dio>()));
}
