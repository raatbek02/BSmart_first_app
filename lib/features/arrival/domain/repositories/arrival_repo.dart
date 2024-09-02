import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_detail_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ArrivalRepo {
  Future<Either<Failure, ArrivalEntity>> getArrivalList(
    String organizationId, {
    int page = 0,
    int size = 10,
  });

  Future<Either<Failure, ArrivalDetailEntity>> getArrivalDetail(
    String organizationId,
    String id,
  );

    Future<Either<Failure, ProductEntity>> getProductList(
    String organizationId, {
    int page = 0,
    int size = 10,
  });

}
