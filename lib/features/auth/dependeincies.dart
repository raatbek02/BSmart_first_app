import 'package:bsmart_first_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:bsmart_first_app/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:bsmart_first_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:bsmart_first_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:bsmart_first_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> initAuthDependencies(GetIt sl) async {
  // Data sources
  sl.registerLazySingleton<AuthRemoteDatabase>(
    () => AuthRemoteDatabaseImpls(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDatabase: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() =>
      AuthUseCase(apiClient: sl(), repository: sl(), sharedPreferences: sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(authUseCase: sl()));
}
