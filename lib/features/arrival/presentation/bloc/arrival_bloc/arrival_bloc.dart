import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/create_arrival_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/providers_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/arrival_usecase.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/create_usecase_usecase.dart';
import 'package:bsmart_first_app/features/arrival/domain/usecase/providers_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'arrival_event.dart';
part 'arrival_state.dart';

class ArrivalBloc extends Bloc<ArrivalEvent, ArrivalState> {
  final ArrivalUseCase arrivalUseCase;
  final CreateArrivalUseCase createArrivalUseCase;
  final ProvidersUseCase providersUseCase;

  ArrivalBloc({
    required this.arrivalUseCase,
    required this.createArrivalUseCase,
    required this.providersUseCase,
  }) : super(ArrivalInitial()) {
    on<FetchArrivalListEvent>(_onFetchArrivalList);
    on<ClearArrivalListEvent>(_onClearArrivalList);
    on<CreateArrivalEvent>(_onCreateArrival);
    on<FetchProvidersEvent>(_onFetchProviders);
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

  // For getting provders
  Future<void> _onFetchProviders(
    FetchProvidersEvent event,
    Emitter<ArrivalState> emit,
  ) async {
    emit(ProvidersLoading());

    final result = await providersUseCase.call(ProvidersParams(
      organizationId: event.organizationId,
    ));

    result.fold(
      (failure) => emit(ProvidersError(failure.message)),
      (providersList) => emit(ProvidersLoaded(providers: providersList)),
    );
  }

  // For create arrival
  Future<void> _onCreateArrival(
    CreateArrivalEvent event,
    Emitter<ArrivalState> emit,
  ) async {
    emit(ArrivalLoading());

    final result = await createArrivalUseCase(CreateArrivalParams(
      organizationId: event.organizationId,
      arrival: event.arrival,
    ));

    result.fold(
      (failure) => emit(ArrivalError(failure.message)),
      (arrivalId) => emit(ArrivalCreated(arrivalId)),
    );
  }
}
