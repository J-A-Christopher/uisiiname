part of 'first_order_reservation_bloc.dart';

abstract class FirstOrderReservationState extends Equatable {
  const FirstOrderReservationState();

  @override
  List<Object> get props => [];
}

class FirstOrderReservationInitial extends FirstOrderReservationState {}

class FirstOrderReservationLoading extends FirstOrderReservationState {}

class FirstOrderReservationLoaded extends FirstOrderReservationState {
  final OrderReservationResponse message;
  const FirstOrderReservationLoaded({required this.message});
  @override
  List<Object> get props => [message];
}

class FirstOrderReservationError extends FirstOrderReservationState {
  final String errorMessage;
  const FirstOrderReservationError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
