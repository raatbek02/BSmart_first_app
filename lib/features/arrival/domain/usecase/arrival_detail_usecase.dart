import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/core/utils/usecases.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_detail_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/repositories/arrival_repo.dart';
import 'package:dartz/dartz.dart';

class ArrivalDetailUseCase
    implements UseCase<ArrivalDetailEntity, ArrivalDetailParams> {
  final ArrivalRepo arrivalRepo;
  ArrivalDetailUseCase({required this.arrivalRepo});

  @override
  Future<Either<Failure, ArrivalDetailEntity>> call(
      ArrivalDetailParams params) {
    return arrivalRepo.getArrivalDetail(
      params.organizationId,
      params.id,
    );
  }
}

class ArrivalDetailParams extends Params {
  final String organizationId;
  final String id;

  ArrivalDetailParams({
    required this.organizationId,
    required this.id,
  }) : super(null);
}


