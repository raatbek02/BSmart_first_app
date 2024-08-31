import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/features/arrival/data/datasources/arrival_remote_datasource.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';
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
}
