

import 'package:bsmart_first_app/features/arrival/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedProductsCubit extends Cubit<List<ProductContentEntity>> {
  SelectedProductsCubit() : super([]);

  void addProduct(ProductContentEntity product) {
    final currentList = List<ProductContentEntity>.from(state);
    currentList.add(product);
    emit(currentList);
  }

  void removeProduct(ProductContentEntity product) {
    final currentList = List<ProductContentEntity>.from(state);
    currentList.remove(product);
    emit(currentList);
  }

  void clearProducts() {
    emit([]);
  }
}
