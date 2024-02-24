part of 'order_status_bloc.dart';

abstract class OrderStatusState extends Equatable {
  const OrderStatusState();

  @override
  List<Object> get props => [];
}

class OrderStatusInitial extends OrderStatusState {}

class OrderStatusLoading extends OrderStatusState {}

class OrderStatusLoaded extends OrderStatusState {
  final OrderResponse orderResponse;
  const OrderStatusLoaded({required this.orderResponse});
   @override
  List<Object> get props => [orderResponse];
}

class OrderStatusError extends OrderStatusState {
  final String message;
  const OrderStatusError({required this.message});
  @override
  List<Object> get props => [message];
}
