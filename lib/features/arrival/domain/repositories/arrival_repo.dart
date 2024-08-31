import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';
import 'package:dartz/dartz.dart';

abstract class ArrivalRepo {
  Future<Either<Failure, ArrivalEntity>> getArrivalList(
    String organizationId, {
    int page = 0,
    int size = 10,
  });
}
