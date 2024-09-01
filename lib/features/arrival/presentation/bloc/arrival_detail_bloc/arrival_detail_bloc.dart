import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_detail_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/arrival_detail_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'arrival_detail_event.dart';
part 'arrival_detail_state.dart';

class ArrivalDetailBloc
    extends Bloc<ArrivalDetailEvent, ArrivalDetailState> {
  final ArrivalDetailUseCase arrivalDetailUseCase;
  ArrivalDetailBloc({required this.arrivalDetailUseCase})
      : super(ArrivalDetailInitial()) {
    on<FetchArrivalDetailEvent>(_onFetchArrivalDetail);
    on<ClearArrivalDetailEvent>(_onClearArrivalDetail);
  }

  Future<void> _onFetchArrivalDetail(
    FetchArrivalDetailEvent event,
    Emitter<ArrivalDetailState> emit,
  ) async {
    if (!event.forceRefresh && state is ArrivalDetailLoaded) {
      return;
    }

    emit(ArrivalDetailLoading());

    final result = await arrivalDetailUseCase.call(ArrivalDetailParams(
      organizationId: event.organizationId,
      id: event.id,
    ));

    result.fold(
      (failure) => emit(ArrivalDetailError(failure.message)),
      (arrivalDetailEntity) => emit(ArrivalDetailLoaded(
        arrivalDetail: arrivalDetailEntity,
      )),
    );
  }

  void _onClearArrivalDetail(
    ClearArrivalDetailEvent event,
    Emitter<ArrivalDetailState> emit,
  ) {
    emit(ArrivalDetailInitial());
  }
}

