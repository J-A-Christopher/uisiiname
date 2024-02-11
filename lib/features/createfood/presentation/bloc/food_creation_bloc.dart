import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usiiname/common/datasources/datasouces.dart';
import 'package:usiiname/common/repository/repository.dart';
import 'package:usiiname/features/createfood/models/create_food_model.dart';

part 'food_creation_event.dart';
part 'food_creation_state.dart';

class FoodCreationBloc extends Bloc<FoodCreationEvent, FoodCreationState> {
  FoodCreationBloc() : super(FoodCreationInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    on<OnFoodCreation>((event, emit) async {
      try {
        emit(FoodCreationInitial());
        final loadedResponse =
            await apiRepository.createFood(event.foodFormationData);
        emit(FoodCreationLoading());
        emit(FoodCreationLoaded(foodData: loadedResponse));
      } catch (error) {
        emit(FoodCreationError(message: error.toString()));
      }
    });
  }
}
