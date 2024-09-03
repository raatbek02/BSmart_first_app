
import 'package:equatable/equatable.dart';

class CreateArrivalEntity extends Equatable {
  final String organizationId;
  final String state;
  final String type;
  final double byCash;
  final double change;
  final String author;
  final DateTime dateTime;
  final int documentNumber;
  final String provider;
  final List<PurchaseEntity> purchases;
  final double totalSumFinal;
  final double totalDiscount;
  final double byCashless;
  final String? id;
  final int count;
  final double totalSum;

  const CreateArrivalEntity({
    required this.organizationId,
    required this.state,
    required this.type,
    required this.byCash,
    required this.change,
    required this.author,
    required this.dateTime,
    required this.documentNumber,
    required this.provider,
    required this.purchases,
    required this.totalSumFinal,
    required this.totalDiscount,
    required this.byCashless,
    this.id,
    required this.count,
    required this.totalSum,
  });

  @override
  List<Object?> get props => [
        organizationId,
        state,
        type,
        byCash,
        change,
        author,
        dateTime,
        documentNumber,
        provider,
        purchases,
        totalSumFinal,
        totalDiscount,
        byCashless,
        id,
        count,
        totalSum,
      ];

  Map<String, dynamic> toJson() {
    return {
      'organizationId': organizationId,
      'state': state,
      'type': type,
      'byCash': byCash,
      'change': change,
      'author': author,
      'dateTime': dateTime.toIso8601String(),
      'documentNumber': documentNumber,
      'provider': provider,
      'purchases': purchases.map((purchase) => purchase.toJson()).toList(),
      'totalSumFinal': totalSumFinal,
      'totalDiscount': totalDiscount,
      'byCashless': byCashless,
      'id': id,
      'count': count,
      'totalSum': totalSum,
    };
  }

  factory CreateArrivalEntity.fromJson(Map<String, dynamic> json) {
    return CreateArrivalEntity(
      organizationId: json['organizationId'],
      state: json['state'],
      type: json['type'],
      byCash: json['byCash'].toDouble(),
      change: json['change'].toDouble(),
      author: json['author'],
      dateTime: DateTime.parse(json['dateTime']),
      documentNumber: json['documentNumber'],
      provider: json['provider'],
      purchases: (json['purchases'] as List)
          .map((purchaseJson) => PurchaseEntity.fromJson(purchaseJson))
          .toList(),
      totalSumFinal: json['totalSumFinal'].toDouble(),
      totalDiscount: json['totalDiscount'].toDouble(),
      byCashless: json['byCashless'].toDouble(),
      id: json['id'],
      count: json['count'],
      totalSum: json['totalSum'].toDouble(),
    );
  }
}

class PurchaseEntity extends Equatable {
  final String productStockId;
  final double amount;
  final double price;
  final double sum;
  final double discount;
  final double sellingPrice;
  final bool bundle;
  final bool service;
  final String? id;
  final String type;

  const PurchaseEntity({
    required this.productStockId,
    required this.amount,
    required this.price,
    required this.sum,
    required this.discount,
    required this.sellingPrice,
    required this.bundle,
    required this.service,
    this.id,
    required this.type,
  });

  @override
  List<Object?> get props => [
        productStockId,
        amount,
        price,
        sum,
        discount,
        sellingPrice,
        bundle,
        service,
        id,
        type,
      ];

  Map<String, dynamic> toJson() {
    return {
      'productStockId': productStockId,
      'amount': amount,
      'price': price,
      'sum': sum,
      'discount': discount,
      'sellingPrice': sellingPrice,
      'bundle': bundle,
      'service': service,
      'id': id,
      'type': type,
    };
  }

  factory PurchaseEntity.fromJson(Map<String, dynamic> json) {
    return PurchaseEntity(
      productStockId: json['productStockId'],
      amount: json['amount'].toDouble(),
      price: json['price'].toDouble(),
      sum: json['sum'].toDouble(),
      discount: json['discount'].toDouble(),
      sellingPrice: json['sellingPrice'].toDouble(),
      bundle: json['bundle'],
      service: json['service'],
      id: json['id'],
      type: json['type'],
    );
  }
}
