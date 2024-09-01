





import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_detail_entity.dart';

class ArrivalDetailModel extends ArrivalDetailEntity {
  const ArrivalDetailModel({
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
    required List<PurchaseModel> super.purchases,
  });

  factory ArrivalDetailModel.fromJson(Map<String, dynamic> json) {
    var purchasesJson = json['purchases'] as List;
    List<PurchaseModel> purchasesList =
        purchasesJson.map((e) => PurchaseModel.fromJson(e)).toList();

    return ArrivalDetailModel(
      id: json['id'] ?? '',
      organizationId: json['organizationId'] ?? '',
      type: json['type'] ?? '',
      provider: json['provider'] ?? '',
      documentNumber: json['documentNumber'] ?? '',
      dateTime:
          DateTime.parse(json['dateTime'] ?? DateTime.now().toIso8601String()),
      author: json['author'] ?? '',
      stock: json['stock'],
      state: json['state'] ?? '',
      totalSum: json['totalSum'] ?? 0.0,
      count: json['count'] ?? 0,
      byCash: json['byCash'] ?? 0.0,
      byCashless: json['byCashless'] ?? 0.0,
      change: json['change'] ?? 0.0,
      totalDiscount: json['totalDiscount'] ?? 0,
      totalSumFinal: json['totalSumFinal'] ?? 0.0,
      purchases: purchasesList,
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
      'purchases': purchases.map((e) => (e as PurchaseModel).toJson()).toList(),
    };
  }
}




class PurchaseModel extends PurchaseEntity {
  const PurchaseModel({
    required super.productStockId,
    required super.id,
    required super.amount,
    required super.price,
    required super.sellingPrice,
    required super.discount,
    required super.sum,
    required super.categoryId,
    required super.unitId,
    super.barcode,
    required super.name,
    super.type,
    required super.balanceStock,
    required super.unitCode,
    super.ettnProductId,
    super.ettnStockId,
    required super.bundle,
    required super.service,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      productStockId: json['productStockId'] ?? '',
      id: json['id'] ?? '',
      amount: json['amount'] ?? 0,
      price: json['price'] ?? 0.0,
      sellingPrice: json['sellingPrice'] ?? 0.0,
      discount: json['discount'] ?? 0,
      sum: json['sum'] ?? 0.0,
      categoryId: json['categoryId'] ?? '',
      unitId: json['unitId'] ?? '',
      barcode: json['barcode'],
      name: json['name'] ?? '',
      type: json['type'],
      balanceStock: json['balanceStock'] ?? 0,
      unitCode: json['unitCode'] ?? '',
      ettnProductId: json['ettnProductId'],
      ettnStockId: json['ettnStockId'],
      bundle: json['bundle'] ?? false,
      service: json['service'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productStockId': productStockId,
      'id': id,
      'amount': amount,
      'price': price,
      'sellingPrice': sellingPrice,
      'discount': discount,
      'sum': sum,
      'categoryId': categoryId,
      'unitId': unitId,
      'barcode': barcode,
      'name': name,
      'type': type,
      'balanceStock': balanceStock,
      'unitCode': unitCode,
      'ettnProductId': ettnProductId,
      'ettnStockId': ettnStockId,
      'bundle': bundle,
      'service': service,
    };
  }
}
