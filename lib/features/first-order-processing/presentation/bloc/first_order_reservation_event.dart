part of 'first_order_reservation_bloc.dart';

abstract class FirstOrderReservationEvent extends Equatable {
  const FirstOrderReservationEvent();

  @override
  List<Object> get props => [];
}

class OnOrderReservation extends FirstOrderReservationEvent {
  final Map<String, dynamic> id;
  const OnOrderReservation({required this.id});
   @override
  List<Object> get props => [id];
}
