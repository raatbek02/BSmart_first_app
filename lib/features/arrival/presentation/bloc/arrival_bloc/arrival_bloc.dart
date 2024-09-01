import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/arrival_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'arrival_event.dart';
part 'arrival_state.dart';

class ArrivalBloc extends Bloc<ArrivalEvent, ArrivalState> {
  final ArrivalUseCase arrivalUseCase;
  ArrivalBloc({required this.arrivalUseCase}) : super(ArrivalInitial()) {
    on<FetchArrivalListEvent>(_onFetchArrivalList);
    on<ClearArrivalListEvent>(_onClearArrivalList);
  }

  Future<void> _onFetchArrivalList(
    FetchArrivalListEvent event,
    Emitter<ArrivalState> emit,
  ) async {
    if (!event.forceRefresh && state is ArrivalLoaded) {
      return;
    }

    emit(ArrivalLoading());

    final result = await arrivalUseCase(PaginationParams(
      organizationId: event.organizationId,
      page: event.page,
      size: event.size,
    ));

    result.fold(
      (failure) => emit(ArrivalError(failure.message)),
      (arrivalEntity) => emit(ArrivalLoaded(
        arrival: arrivalEntity,
        totalPages: arrivalEntity.totalPages,
        totalElements: arrivalEntity.totalElements,
      )),
    );
  }

  void _onClearArrivalList(
    ClearArrivalListEvent event,
    Emitter<ArrivalState> emit,
  ) {
    emit(ArrivalInitial());
  }
}





