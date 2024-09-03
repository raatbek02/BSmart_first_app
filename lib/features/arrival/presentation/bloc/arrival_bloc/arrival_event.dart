part of 'arrival_bloc.dart';

sealed class ArrivalEvent extends Equatable {
  const ArrivalEvent();

  @override
  List<Object> get props => [];
}

final class FetchArrivalListEvent extends ArrivalEvent {
  final String organizationId;
  final int page;
  final int size;
  final bool forceRefresh;

  const FetchArrivalListEvent({
    required this.organizationId,
    this.page = 0,
    this.size = 10,
    this.forceRefresh = false,
  });

  @override
List<Object> get props => [organizationId, page, size, forceRefresh];
}

final class ClearArrivalListEvent extends ArrivalEvent {}




// For create arrival
final class CreateArrivalEvent extends ArrivalEvent {
  final String organizationId;
  final CreateArrivalEntity arrival;

  const CreateArrivalEvent({
    required this.organizationId,
    required this.arrival,
  });

  @override
  List<Object> get props => [organizationId, arrival];
}
