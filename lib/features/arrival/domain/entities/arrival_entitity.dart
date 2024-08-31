

import 'package:equatable/equatable.dart';

class ArrivalEntity extends Equatable {
  final int totalPages;
  final int totalElements;
  final int size;
  final List<ArrivalContentEntity> content;
  final int number;
  final SortEntity sort;
  final int numberOfElements;
  final PageableEntity pageable;
  final bool first;
  final bool last;
  final bool empty;

  const ArrivalEntity({
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.content,
    required this.number,
    required this.sort,
    required this.numberOfElements,
    required this.pageable,
    required this.first,
    required this.last,
    required this.empty,
  });

  @override
  List<Object?> get props => [
        totalPages,
        totalElements,
        size,
        content,
        number,
        sort,
        numberOfElements,
        pageable,
        first,
        last,
        empty,
      ];
}

class ArrivalContentEntity extends Equatable {
  final String id;
  final String organizationId;
  final String type;
  final String provider;
  final String documentNumber;
  final DateTime dateTime;
  final String author;
  final String? stock;
  final String state;
  final double totalSum;
  final int count;
  final double byCash;
  final double byCashless;
  final double change;
  final int totalDiscount;
  final double totalSumFinal;

  const ArrivalContentEntity({
    required this.id,
    required this.organizationId,
    required this.type,
    required this.provider,
    required this.documentNumber,
    required this.dateTime,
    required this.author,
    this.stock,
    required this.state,
    required this.totalSum,
    required this.count,
    required this.byCash,
    required this.byCashless,
    required this.change,
    required this.totalDiscount,
    required this.totalSumFinal,
  });

  @override
  List<Object?> get props => [
        id,
        organizationId,
        type,
        provider,
        documentNumber,
        dateTime,
        author,
        stock,
        state,
        totalSum,
        count,
        byCash,
        byCashless,
        change,
        totalDiscount,
        totalSumFinal,
      ];
}

class SortEntity extends Equatable {
  final bool empty;
  final bool sorted;
  final bool unsorted;

  const SortEntity({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });

  @override
  List<Object?> get props => [empty, sorted, unsorted];
}

class PageableEntity extends Equatable {
  final int offset;
  final SortEntity sort;
  final bool paged;
  final int pageNumber;
  final int pageSize;
  final bool unpaged;

  const PageableEntity({
    required this.offset,
    required this.sort,
    required this.paged,
    required this.pageNumber,
    required this.pageSize,
    required this.unpaged,
  });

  @override
  List<Object?> get props => [
        offset,
        sort,
        paged,
        pageNumber,
        pageSize,
        unpaged,
      ];
}
