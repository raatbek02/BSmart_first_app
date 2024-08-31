import 'package:bsmart_first_app/core/api/api_client.dart';
import 'package:bsmart_first_app/core/api/api_constants.dart';
import 'package:bsmart_first_app/features/arrival/dependeincies.dart';
import 'package:bsmart_first_app/features/auth/dependeincies.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());

  // // Core
  sl.registerLazySingleton(() => ApiClient(
        appBaseUrl: ApiConstants.BASE_URL,
        sharedPreferences: sl(),
      ));

  // // Feature dependencies
  await initAuthDependencies(sl);
  await initArrivalDependencies(sl);

  // // Common cubits
  // sl.registerFactory(() => SelectBranchIdCubit());

}
