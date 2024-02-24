part of 'order_status_bloc.dart';

abstract class OrderStatusEvent extends Equatable {
  const OrderStatusEvent();

  @override
  List<Object> get props => [];
}

class OnOrderStatus extends OrderStatusEvent {
  final Map<String, dynamic> orderStatus;
  const OnOrderStatus({required this.orderStatus});
    @override
  List<Object> get props => [orderStatus];

}
