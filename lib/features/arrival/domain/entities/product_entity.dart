import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int totalPages;
  final int totalElements;
  final int size;
  final List<ProductContentEntity> content;
  final int number;
  final SortEntity sort;
  final int numberOfElements;
  final PageableEntity pageable;
  final bool first;
  final bool last;
  final bool empty;

  const ProductEntity({
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

class ProductContentEntity extends Equatable {
  final String id;
  final String productStockId;
  final String organizationId;
  final String name;
  final String article;
  final String categoryId;
  final String unitId;
  final List<String> barcodes;
  final double purchasePrice;
  final double sellingPrice;
  final double balanceStock;
  final String stockId;
  final String stockName;
  final double discountPercent;
  final double discountSum;
  final DateTime discountEnd;
  final String brand;
  final double wholesalePrice;
  final String tnvedCode;
  final String ettnProductId;
  final String ettnStockId;
  final bool weighed;
  final bool service;

  const ProductContentEntity({
    required this.id,
    required this.productStockId,
    required this.organizationId,
    required this.name,
    required this.article,
    required this.categoryId,
    required this.unitId,
    required this.barcodes,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.balanceStock,
    required this.stockId,
    required this.stockName,
    required this.discountPercent,
    required this.discountSum,
    required this.discountEnd,
    required this.brand,
    required this.wholesalePrice,
    required this.tnvedCode,
    required this.ettnProductId,
    required this.ettnStockId,
    required this.weighed,
    required this.service,
  });

  @override
  List<Object?> get props => [
        id,
        productStockId,
        organizationId,
        name,
        article,
        categoryId,
        unitId,
        barcodes,
        purchasePrice,
        sellingPrice,
        balanceStock,
        stockId,
        stockName,
        discountPercent,
        discountSum,
        discountEnd,
        brand,
        wholesalePrice,
        tnvedCode,
        ettnProductId,
        ettnStockId,
        weighed,
        service,
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
