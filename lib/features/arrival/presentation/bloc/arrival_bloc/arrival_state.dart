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




