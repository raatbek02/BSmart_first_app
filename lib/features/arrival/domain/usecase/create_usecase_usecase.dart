

import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/core/utils/usecases.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/create_arrival_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/repositories/arrival_repo.dart';
import 'package:dartz/dartz.dart';

class CreateArrivalUseCase implements UseCase<String, CreateArrivalParams> {
  final ArrivalRepo arrivalRepo;

  CreateArrivalUseCase({required this.arrivalRepo});

  @override
  Future<Either<Failure, String>> call(CreateArrivalParams params) {
    return arrivalRepo.createArrival(params.organizationId, params.arrival);
  }
}

class CreateArrivalParams extends Params {
  final String organizationId;
  final CreateArrivalEntity arrival;

  CreateArrivalParams({
    required this.organizationId,
    required this.arrival,
  }) : super(null);
}
