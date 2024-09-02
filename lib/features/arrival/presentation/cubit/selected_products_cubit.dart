import 'package:bsmart_first_app/core/helpers/my_logger.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class SelectedProductsCubit extends Cubit<List<ProductContentEntity>> {
//   SelectedProductsCubit() : super([]);

//   void addProduct(ProductContentEntity product) {
//     final currentList = List<ProductContentEntity>.from(state);

//     // Проверяем, есть ли уже такой продукт в списке
//     final isProductAlreadyAdded = currentList.any((p) => p.id == product.id);

//     if (!isProductAlreadyAdded) {
//       currentList.add(product);
//       emit(currentList);
//       logger.i("Product added: ${product.name}");
//     } else {
//       logger.w("Product already added: ${product.name}");
//     }
//   }

//   void removeProduct(ProductContentEntity product) {
//     final currentList = List<ProductContentEntity>.from(state);
//     currentList.removeWhere((p) => p.id == product.id);
//     emit(currentList);
//   }

//   void clearProducts() {
//     emit([]);
//   }
// }


class SelectedProductsState extends Equatable {
  final List<ProductWithQuantity> products;
  final int totalQuantity;
  final double totalPurchasePrice;

  const SelectedProductsState({
    required this.products,
    required this.totalQuantity,
    required this.totalPurchasePrice,
  });

  @override
  List<Object> get props => [products, totalQuantity, totalPurchasePrice];

  SelectedProductsState copyWith({
    List<ProductWithQuantity>? products,
    int? totalQuantity,
    double? totalPurchasePrice,
  }) {
    return SelectedProductsState(
      products: products ?? this.products,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalPurchasePrice: totalPurchasePrice ?? this.totalPurchasePrice,
    );
  }
}

class ProductWithQuantity extends Equatable {
  final ProductContentEntity product;
  final int quantity;

  const ProductWithQuantity({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object> get props => [product, quantity];

  ProductWithQuantity copyWith({
    ProductContentEntity? product,
    int? quantity,
  }) {
    return ProductWithQuantity(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

class SelectedProductsCubit extends Cubit<SelectedProductsState> {
  SelectedProductsCubit()
      : super(const SelectedProductsState(
            products: [], totalQuantity: 0, totalPurchasePrice: 0));

  void addProduct(ProductContentEntity product) {
    final currentProducts = List<ProductWithQuantity>.from(state.products);
    final existingProductIndex =
        currentProducts.indexWhere((p) => p.product.id == product.id);

    if (existingProductIndex != -1) {
      currentProducts[existingProductIndex] =
          currentProducts[existingProductIndex].copyWith(
        quantity: currentProducts[existingProductIndex].quantity + 1,
      );
    } else {
      currentProducts.add(ProductWithQuantity(product: product, quantity: 1));
    }

    _emitUpdatedState(currentProducts);
  }

  void removeProduct(String productId) {
    final currentProducts =
        state.products.where((p) => p.product.id != productId).toList();
    _emitUpdatedState(currentProducts);
  }

  void updateProductQuantity(String productId, int newQuantity) {
    final currentProducts = List<ProductWithQuantity>.from(state.products);
    final productIndex =
        currentProducts.indexWhere((p) => p.product.id == productId);

    if (productIndex != -1) {
      currentProducts[productIndex] =
          currentProducts[productIndex].copyWith(quantity: newQuantity);
      _emitUpdatedState(currentProducts);
    }
  }

  void _emitUpdatedState(List<ProductWithQuantity> products) {
    final totalQuantity = products.fold(0, (sum, item) => sum + item.quantity);
    final totalPurchasePrice = products.fold(
        0.0, (sum, item) => sum + (item.product.purchasePrice * item.quantity));

    emit(SelectedProductsState(
      products: products,
      totalQuantity: totalQuantity,
      totalPurchasePrice: totalPurchasePrice,
    ));
  }

  void clearProducts() {
    emit(const SelectedProductsState(
        products: [], totalQuantity: 0, totalPurchasePrice: 0));
  }
}
