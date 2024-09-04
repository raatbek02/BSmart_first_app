import 'package:bsmart_first_app/features/arrival/data/datasources/arrival_remote_datasource.dart';
import 'package:bsmart_first_app/features/arrival/data/repositories/arrival_repo_impl.dart';
import 'package:bsmart_first_app/features/arrival/domain/repositories/arrival_repo.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/arrival_detail_usecase.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/arrival_usecase.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/create_usecase_usecase.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/product_list_usecase.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/providers_usecase.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/arrival_bloc/arrival_bloc.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/arrival_detail_bloc/arrival_detail_bloc.dart';
import 'package:bsmart_first_app/features/arrival/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:bsmart_first_app/features/arrival/presentation/cubit/selected_products_cubit.dart';
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
  sl.registerLazySingleton(() => ProductListUsecase(arrivalRepo: sl()));
  sl.registerLazySingleton(() => CreateArrivalUseCase(arrivalRepo: sl()));
  sl.registerLazySingleton(() => ProvidersUseCase(arrivalRepo: sl()));




  // Blocs
  sl.registerFactory(() => ArrivalBloc(arrivalUseCase: sl(), createArrivalUseCase: sl(), providersUseCase: sl()));
  sl.registerFactory(() => ArrivalDetailBloc(arrivalDetailUseCase: sl()));
  sl.registerFactory(() => ProductBloc(productListUsecase: sl()));

  // Cubits
  sl.registerFactory(() => SelectedProductsCubit());
}
