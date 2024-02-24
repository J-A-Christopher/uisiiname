import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usiiname/common/repository/repository.dart';
import 'package:usiiname/features/orderstatus/model/order_status_response.dart';

part 'order_status_event.dart';
part 'order_status_state.dart';

class OrderStatusBloc extends Bloc<OrderStatusEvent, OrderStatusState> {
  OrderStatusBloc() : super(OrderStatusInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<OnOrderStatus>((event, emit) async {
      try {
        emit(OrderStatusInitial());
        final userOrderData =
            await apiRepository.processOrderByFoodOwner(event.orderStatus);
        emit(OrderStatusLoading());
        emit(OrderStatusLoaded(orderResponse: userOrderData));
      } catch (error) {
        emit(OrderStatusError(message: error.toString()));
      }
    });
  }
}
