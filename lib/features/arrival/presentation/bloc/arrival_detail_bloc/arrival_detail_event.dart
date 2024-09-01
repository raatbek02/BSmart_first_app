part of 'arrival_detail_bloc.dart';

sealed class ArrivalDetailEvent extends Equatable {
  const ArrivalDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchArrivalDetailEvent extends ArrivalDetailEvent {
  final String organizationId;
  final String id;
  final bool forceRefresh;

  const FetchArrivalDetailEvent({
    required this.organizationId,
    required this.id,
    this.forceRefresh = false,
  });

  @override
  List<Object> get props => [organizationId, id];
}

class ClearArrivalDetailEvent extends ArrivalDetailEvent {}






