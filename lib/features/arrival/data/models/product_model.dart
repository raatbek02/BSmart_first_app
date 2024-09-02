import 'package:bsmart_first_app/features/arrival/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.totalPages,
    required super.totalElements,
    required super.size,
    required List<ProductContentModel> super.content,
    required super.number,
    required SortModel super.sort,
    required super.numberOfElements,
    required PageableModel super.pageable,
    required super.first,
    required super.last,
    required super.empty,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      size: json['size'] ?? 0,
      content: (json['content'] as List)
          .map((item) => ProductContentModel.fromJson(item))
          .toList(),
      number: json['number'] ?? 0,
      sort: SortModel.fromJson(json['sort'] ?? {}),
      numberOfElements: json['numberOfElements'] ?? 0,
      pageable: PageableModel.fromJson(json['pageable'] ?? {}),
      first: json['first'] ?? false,
      last: json['last'] ?? false,
      empty: json['empty'] ?? false,
    );
  }
}

class ProductContentModel extends ProductContentEntity {
  const ProductContentModel({
    required super.id,
    required super.productStockId,
    required super.organizationId,
    required super.name,
    required super.article,
    required super.categoryId,
    required super.unitId,
    required super.barcodes,
    required super.purchasePrice,
    required super.sellingPrice,
    required super.balanceStock,
    required super.stockId,
    required super.stockName,
    required super.discountPercent,
    required super.discountSum,
    required super.discountEnd,
    required super.brand,
    required super.wholesalePrice,
    required super.tnvedCode,
    required super.ettnProductId,
    required super.ettnStockId,
    required super.weighed,
    required super.service,
  });

  factory ProductContentModel.fromJson(Map<String, dynamic> json) {
    DateTime? discountEnd;

    try {
      discountEnd =
          json['discountEnd'] != null && json['discountEnd'].isNotEmpty
              ? DateTime.parse(json['discountEnd'])
              : null;
    } catch (e) {
      discountEnd = null;
    }

    return ProductContentModel(
      id: json['id'] ?? '',
      productStockId: json['productStockId'] ?? '',
      organizationId: json['organizationId'] ?? '',
      name: json['name'] ?? '',
      article: json['article'] ?? '',
      categoryId: json['categoryId'] ?? '',
      unitId: json['unitId'] ?? '',
      barcodes: List<String>.from(json['barcodes'] ?? []),
      purchasePrice: json['purchasePrice']?.toDouble() ?? 0.0,
      sellingPrice: json['sellingPrice']?.toDouble() ?? 0.0,
      balanceStock: json['balanceStock']?.toDouble() ?? 0.0,
      stockId: json['stockId'] ?? '',
      stockName: json['stockName'] ?? '',
      discountPercent: json['discountPercent']?.toDouble() ?? 0.0,
      discountSum: json['discountSum']?.toDouble() ?? 0.0,
      discountEnd: discountEnd ??
          DateTime.now(), // Используем безопасно распарсенную дату
      brand: json['brand'] ?? '',
      wholesalePrice: json['wholesalePrice']?.toDouble() ?? 0.0,
      tnvedCode: json['tnvedCode'] ?? '',
      ettnProductId: json['ettnProductId'] ?? '',
      ettnStockId: json['ettnStockId'] ?? '',
      weighed: json['weighed'] ?? false,
      service: json['service'] ?? false,
    );
  }
}

class SortModel extends SortEntity {
  const SortModel({
    required super.empty,
    required super.sorted,
    required super.unsorted,
  });

  factory SortModel.fromJson(Map<String, dynamic> json) {
    return SortModel(
      empty: json['empty'] ?? false,
      sorted: json['sorted'] ?? false,
      unsorted: json['unsorted'] ?? false,
    );
  }
}

class PageableModel extends PageableEntity {
  const PageableModel({
    required super.offset,
    required SortModel super.sort,
    required super.paged,
    required super.pageNumber,
    required super.pageSize,
    required super.unpaged,
  });

  factory PageableModel.fromJson(Map<String, dynamic> json) {
    return PageableModel(
      offset: json['offset'] ?? 0,
      sort: SortModel.fromJson(json['sort'] ?? {}),
      paged: json['paged'] ?? false,
      pageNumber: json['pageNumber'] ?? 0,
      pageSize: json['pageSize'] ?? 0,
      unpaged: json['unpaged'] ?? false,
    );
  }
}
