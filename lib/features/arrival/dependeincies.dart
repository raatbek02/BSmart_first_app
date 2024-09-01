import 'package:bsmart_first_app/features/arrival/data/datasources/arrival_remote_datasource.dart';
import 'package:bsmart_first_app/features/arrival/data/repositories/arrival_repo_impl.dart';
import 'package:bsmart_first_app/features/arrival/domain/repositories/arrival_repo.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/arrival_detail_usecase.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/arrival_usecase.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/arrival_bloc/arrival_bloc.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/arrival_detail_bloc/arrival_detail_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> initArrivalDependencies(GetIt sl) async {
  // Data sources
  sl.registerLazySingleton<ArrivalRemoteDataSource>(
    () => ArrivalRemoteDataSourceImpl(apiClient: sl()),
  );

  // Repository
  sl.registerLazySingleton<ArrivalRepo>(
    () => ArrivalRepoImpl(remoteDatasource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => ArrivalUseCase(arrivalRepo: sl()));
  sl.registerLazySingleton(() => ArrivalDetailUseCase(arrivalRepo: sl()));

  // Blocs
  sl.registerFactory(() => ArrivalBloc(arrivalUseCase: sl()));
  sl.registerFactory(()=> ArrivalDetailBloc(arrivalDetailUseCase: sl())); 
}
