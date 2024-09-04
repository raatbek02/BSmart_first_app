import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/core/utils/usecases.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/providers_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/repositories/arrival_repo.dart';
import 'package:dartz/dartz.dart';

class ProvidersUseCase
    implements UseCase<List<ProvidersEntity>, ProvidersParams> {
  final ArrivalRepo arrivalRepo;
  ProvidersUseCase({required this.arrivalRepo});

  @override
  Future<Either<Failure, List<ProvidersEntity>>> call(ProvidersParams params) {
    return arrivalRepo.getProviders(params.organizationId);
  }
}

class ProvidersParams extends Params {
  final String organizationId;

  ProvidersParams({
    required this.organizationId,
  }) : super(null);
}
