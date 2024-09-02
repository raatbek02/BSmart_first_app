part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final ProductEntity product;
  final int totalPages;
  final int totalElements;

  const ProductLoaded({
    required this.product,
    required this.totalPages,
    required this.totalElements,
  });

  @override
  List<Object> get props => [product, totalPages, totalElements];
}

final class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}






