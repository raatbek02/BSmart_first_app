import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/core/utils/usecases.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';
import 'package:bsmart_first_app/features/arrival/domain/repositories/arrival_repo.dart';
import 'package:dartz/dartz.dart';

class ArrivalUseCase implements UseCase<ArrivalEntity, PaginationParams> {
  final ArrivalRepo arrivalRepo;

  ArrivalUseCase({required this.arrivalRepo});

  @override
  Future<Either<Failure, ArrivalEntity>> call(PaginationParams params) {
    int page = params.page ?? 0;
    int size = params.size ?? 10;
    return arrivalRepo.getArrivalList(
      params.organizationId,
      page: page,
      size: size,
    );
  }
}

class PaginationParams extends Params {
  final String organizationId;
  final int? page;
  final int? size;

  PaginationParams({
    required this.organizationId,
    this.page,
    this.size,
  }) : super(null);
}
