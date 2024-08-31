
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';

class ArrivalModel extends ArrivalEntity {
  const ArrivalModel({
    required super.totalPages,
    required super.totalElements,
    required super.size,
    required List<ArrivalContentModel> super.content,
    required super.number,
    required SortModel super.sort,
    required super.numberOfElements,
    required PageableModel super.pageable,
    required super.first,
    required super.last,
    required super.empty,
  });

  factory ArrivalModel.fromJson(Map<String, dynamic> json) {
    return ArrivalModel(
      totalPages: json['totalPages'] ?? 0,
      totalElements: json['totalElements'] ?? 0,
      size: json['size'] ?? 0,
      content: (json['content'] as List)
              .map((item) => ArrivalContentModel.fromJson(item))
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

  Map<String, dynamic> toJson() {
    return {
      'totalPages': totalPages,
      'totalElements': totalElements,
      'size': size,
      'content': content
          .map((item) => (item as ArrivalContentModel).toJson())
          .toList(),
      'number': number,
      'sort': (sort as SortModel).toJson(),
      'numberOfElements': numberOfElements,
      'pageable': (pageable as PageableModel).toJson(),
      'first': first,
      'last': last,
      'empty': empty,
    };
  }
}

class ArrivalContentModel extends ArrivalContentEntity {
  const ArrivalContentModel({
    required super.id,
    required super.organizationId,
    required super.type,
    required super.provider,
    required super.documentNumber,
    required super.dateTime,
    required super.author,
    super.stock,
    required super.state,
    required super.totalSum,
    required super.count,
    required super.byCash,
    required super.byCashless,
    required super.change,
    required super.totalDiscount,
    required super.totalSumFinal,
  });

  factory ArrivalContentModel.fromJson(Map<String, dynamic> json) {
    return ArrivalContentModel(
      id: json['id'] ?? '',
      organizationId: json['organizationId'] ?? '',
      type: json['type'] ?? '',
      provider: json['provider'] ?? '',
      documentNumber: json['documentNumber'] ?? '',
      dateTime: DateTime.parse(json['dateTime'] ?? DateTime.now().toString()),
      author: json['author'] ?? '',
      stock: json['stock'],
      state: json['state'] ?? '',
      totalSum: (json['totalSum'] as num?)?.toDouble() ?? 0.0,
      count: json['count'] ?? 0,
      byCash: (json['byCash'] as num?)?.toDouble() ?? 0.0,
      byCashless: (json['byCashless'] as num?)?.toDouble() ?? 0.0,
      change: (json['change'] as num?)?.toDouble() ?? 0.0,
      totalDiscount: json['totalDiscount'] ?? 0,
      totalSumFinal: (json['totalSumFinal'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'type': type,
      'provider': provider,
      'documentNumber': documentNumber,
      'dateTime': dateTime.toIso8601String(),
      'author': author,
      'stock': stock,
      'state': state,
      'totalSum': totalSum,
      'count': count,
      'byCash': byCash,
      'byCashless': byCashless,
      'change': change,
      'totalDiscount': totalDiscount,
      'totalSumFinal': totalSumFinal,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'empty': empty,
      'sorted': sorted,
      'unsorted': unsorted,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'offset': offset,
      'sort': sort,
      'paged': paged,
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'unpaged': unpaged,
    };
  }
}
