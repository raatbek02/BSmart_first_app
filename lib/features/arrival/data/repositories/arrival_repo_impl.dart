import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/features/arrival/data/datasources/arrival_remote_datasource.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_detail_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/product_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/repositories/arrival_repo.dart';
import 'package:dartz/dartz.dart';

class ArrivalRepoImpl implements ArrivalRepo {
  final ArrivalRemoteDataSource remoteDatasource;

  ArrivalRepoImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, ArrivalEntity>> getArrivalList(String organizationId,
      {int page = 0, int size = 10}) async {
    try {
      ArrivalEntity results = await remoteDatasource.listArrival(
        organizationId,
        page: page,
        size: size,
      );
      return Right(results);
    } catch (e) {
      return Left(Failure("List of arrival FAILED: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, ArrivalDetailEntity>> getArrivalDetail(
      String organizationId, String id) async {
  
    try { 
      ArrivalDetailEntity results = await remoteDatasource.getArrivalDetail(
        organizationId,
        id,
      );
      return Right(results);
    } catch (e) {
      return Left(Failure("Arrival detail FAAAILED: ${e.toString()}"));
    }
    
  }

  @override
  Future<Either<Failure, ProductEntity>> getProductList(String organizationId, {int page = 0, int size = 10}) async {
    try {
      ProductEntity results = await remoteDatasource.getProductList(
        organizationId,
        page: page,
        size: size,
      );
      return Right(results);
    } catch (e) {
      return Left(Failure("List of products FAILED: ${e.toString()}"));
    }
  }
}
