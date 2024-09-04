part of 'arrival_bloc.dart';

sealed class ArrivalState extends Equatable {
  const ArrivalState();
  
  @override
  List<Object> get props => [];
}

final class ArrivalInitial extends ArrivalState {}

final class ArrivalLoading extends ArrivalState {}

final class ArrivalLoaded extends ArrivalState {
  final ArrivalEntity arrival;
  final int totalPages;
  final int totalElements;

  const ArrivalLoaded({
    required this.arrival,
    required this.totalPages,
    required this.totalElements,
  });

  @override
  List<Object> get props => [arrival, totalPages, totalElements];
}

final class ArrivalError extends ArrivalState {
  final String message;

  const ArrivalError(this.message);

  @override
  List<Object> get props => [message];
}

// For getting provders
final class ProvidersLoading extends ArrivalState {}

final class ProvidersLoaded extends ArrivalState {
  final List<ProvidersEntity> providers;

  const ProvidersLoaded({required this.providers});

  @override
  List<Object> get props => [providers];
}

final class ProvidersError extends ArrivalState {
  final String message;

  const ProvidersError(this.message);

  @override
  List<Object> get props => [message];
}

// For create arrival
final class ArrivalCreated extends ArrivalState {
  final String arrivalId;

  const ArrivalCreated(this.arrivalId);

  @override
  List<Object> get props => [arrivalId];
}


