part of 'food_creation_bloc.dart';

abstract class FoodCreationEvent extends Equatable {
  const FoodCreationEvent();

  @override
  List<Object> get props => [];
}

class OnFoodCreation extends FoodCreationEvent {
  final Map<String, dynamic> foodFormationData;
 const  OnFoodCreation({required this.foodFormationData});
  @override
  List<Object> get props => [foodFormationData];
}
