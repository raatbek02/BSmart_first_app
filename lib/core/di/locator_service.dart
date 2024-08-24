// import 'package:cheber_bloc_clean/common/cubits/select_branch_id_cubit.dart.dart';
// import 'package:cheber_bloc_clean/core/api/api_client.dart';
// import 'package:cheber_bloc_clean/core/utils/app_constants.dart';
// import 'package:cheber_bloc_clean/features/appointments/dependeincies.dart';
// import 'package:cheber_bloc_clean/features/auth/dependeincies.dart';
// import 'package:cheber_bloc_clean/features/bonus/dependeincies.dart';
// import 'package:cheber_bloc_clean/features/categories/dependencies.dart';
// import 'package:cheber_bloc_clean/features/home/dependeincies.dart';
// import 'package:cheber_bloc_clean/features/profile/dependeincies.dart';
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
  // sl.registerLazySingleton(() => ApiClient(
  //       appBaseUrl: AppConstants.BASE_URL,
  //       sharedPreferences: sl(),
  //     ));

  // // Feature dependencies
  // await initCategoriesDependencies(sl);
  // await initAuthDependencies(sl);
  // await initProfileDependencies(sl);
  // await initBonusDependencies(sl);
  // await initBranchesMainDependencies(sl);
  // await initAppointmentsDependencies(sl);

  // // Common cubits
  // sl.registerFactory(() => SelectBranchIdCubit());
}
