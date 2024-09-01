part of 'arrival_detail_bloc.dart';

sealed class ArrivalDetailState extends Equatable {
  const ArrivalDetailState();
  
  @override
  List<Object> get props => [];
}

final class ArrivalDetailInitial extends ArrivalDetailState {}

final class ArrivalDetailLoading extends ArrivalDetailState {}

final class ArrivalDetailLoaded extends ArrivalDetailState {
  final ArrivalDetailEntity arrivalDetail;
  
  const ArrivalDetailLoaded({
    required this.arrivalDetail,
  });
  
  @override
  List<Object> get props => [arrivalDetail];
}

final class ArrivalDetailError extends ArrivalDetailState {
  final String message;
  
  const ArrivalDetailError(this.message);
  
  @override
  List<Object> get props => [message];
}



