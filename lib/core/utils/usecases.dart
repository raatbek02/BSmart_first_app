

import 'package:bsmart_first_app/core/errors/errors.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class Params<T> {
  final T data;
  Params(this.data);
}

class IdWithDataParams<T> extends Params {
  final int id;
  // final T data;

  IdWithDataParams(this.id, super.data) : super();
}

class NoParams {
  NoParams();
}

class PaginationParams extends Params {
  final int? id;
  final int? page;
  final int? size;

  PaginationParams({
    this.id,
    this.page,
    this.size,
  }) : super(null);
}



