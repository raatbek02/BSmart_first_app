import 'package:bsmart_first_app/features/arrival/domain/entities/product_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/product_list_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductListUsecase productListUsecase;
  ProductBloc({required this.productListUsecase}) : super(ProductInitial()) {
    on<FetchProductListEvent>(_onFetchProductList);
    on<ClearProductListEvent>(_onClearProductList);
  }

  Future<void> _onFetchProductList(
    FetchProductListEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (!event.forceRefresh && state is ProductLoaded) {
      return;
    }

    emit(ProductLoading());

    final result = await productListUsecase(PaginationParams(
      organizationId: event.organizationId,
      page: event.page,
      size: event.size,
    ));

    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (productEntity) => emit(ProductLoaded(
        product: productEntity,
        totalPages: productEntity.totalPages,
        totalElements: productEntity.totalElements,
      )),
    );
  }

  void _onClearProductList(
    ClearProductListEvent event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductInitial());
  }
}




// class ArrivalBloc extends Bloc<ArrivalEvent, ArrivalState> {
//   final ArrivalUseCase arrivalUseCase;
//   ArrivalBloc({required this.arrivalUseCase}) : super(ArrivalInitial()) {
//     on<FetchArrivalListEvent>(_onFetchArrivalList);
//     on<ClearArrivalListEvent>(_onClearArrivalList);
//   }

//   Future<void> _onFetchArrivalList(
//     FetchArrivalListEvent event,
//     Emitter<ArrivalState> emit,
//   ) async {
//     if (!event.forceRefresh && state is ArrivalLoaded) {
//       return;
//     }

//     emit(ArrivalLoading());

//     final result = await arrivalUseCase(PaginationParams(
//       organizationId: event.organizationId,
//       page: event.page,
//       size: event.size,
//     ));

//     result.fold(
//       (failure) => emit(ArrivalError(failure.message)),
//       (arrivalEntity) => emit(ArrivalLoaded(
//         arrival: arrivalEntity,
//         totalPages: arrivalEntity.totalPages,
//         totalElements: arrivalEntity.totalElements,
//       )),
//     );
//   }

//   void _onClearArrivalList(
//     ClearArrivalListEvent event,
//     Emitter<ArrivalState> emit,
//   ) {
//     emit(ArrivalInitial());
//   }
// }
