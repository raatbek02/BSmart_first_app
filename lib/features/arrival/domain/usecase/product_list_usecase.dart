

import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:bsmart_first_app/core/utils/usecases.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/product_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/repositories/arrival_repo.dart';
import 'package:dartz/dartz.dart';


class ProductListUsecase implements UseCase<ProductEntity, PaginationParams> {
  final ArrivalRepo arrivalRepo;

  ProductListUsecase({required this.arrivalRepo});

  @override
  Future<Either<Failure, ProductEntity>> call(PaginationParams params) {
    int page = params.page ?? 0;
    int size = params.size ?? 10;
    return arrivalRepo.getProductList(
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



