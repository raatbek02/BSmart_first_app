
import 'package:equatable/equatable.dart';



class ArrivalDetailEntity extends Equatable {
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
  final List<PurchaseEntity> purchases;

  const ArrivalDetailEntity({
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
    required this.purchases,
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
        purchases,
      ];
}


class PurchaseEntity extends Equatable {
  final String productStockId;
  final String id;
  final int amount;
  final double price;
  final double sellingPrice;
  final int discount;
  final double sum;
  final String categoryId;
  final String unitId;
  final String? barcode;
  final String name;
  final String? type;
  final int balanceStock;
  final String unitCode;
  final String? ettnProductId;
  final String? ettnStockId;
  final bool bundle;
  final bool service;

  const PurchaseEntity({
    required this.productStockId,
    required this.id,
    required this.amount,
    required this.price,
    required this.sellingPrice,
    required this.discount,
    required this.sum,
    required this.categoryId,
    required this.unitId,
    this.barcode,
    required this.name,
    this.type,
    required this.balanceStock,
    required this.unitCode,
    this.ettnProductId,
    this.ettnStockId,
    required this.bundle,
    required this.service,
  });

  @override
  List<Object?> get props => [
        productStockId,
        id,
        amount,
        price,
        sellingPrice,
        discount,
        sum,
        categoryId,
        unitId,
        barcode,
        name,
        type,
        balanceStock,
        unitCode,
        ettnProductId,
        ettnStockId,
        bundle,
        service,
      ];
}
