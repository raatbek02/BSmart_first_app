part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class FetchProductListEvent extends ProductEvent {
  final String organizationId;
  final int page;
  final int size;
  final bool forceRefresh;

  const FetchProductListEvent({
    required this.organizationId,
    this.page = 0,
    this.size = 10,
    this.forceRefresh = false,
  });

  @override
  List<Object> get props => [organizationId, page, size, forceRefresh];
}

final class ClearProductListEvent extends ProductEvent {}





