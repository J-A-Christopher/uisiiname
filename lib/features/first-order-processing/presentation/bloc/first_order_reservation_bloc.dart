import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usiiname/common/repository/repository.dart';
import 'package:usiiname/features/first-order-processing/models/first_order_processing_response.dart';

part 'first_order_reservation_event.dart';
part 'first_order_reservation_state.dart';

class FirstOrderReservationBloc
    extends Bloc<FirstOrderReservationEvent, FirstOrderReservationState> {
  FirstOrderReservationBloc() : super(FirstOrderReservationInitial()) {
     final ApiRepository apiRepository = ApiRepository();
    on<OnOrderReservation>((event, emit) async{
      try {
        emit(FirstOrderReservationInitial());
        emit(FirstOrderReservationLoading());
         final onOrderReservation = await apiRepository.orderFood(event.id);
        emit(FirstOrderReservationLoaded(message: onOrderReservation));
      } catch (error) {
        emit(FirstOrderReservationError(errorMessage: error.toString()));
      }
    });
  }
}
