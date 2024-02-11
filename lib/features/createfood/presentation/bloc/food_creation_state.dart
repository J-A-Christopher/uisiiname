part of 'food_creation_bloc.dart';

abstract class FoodCreationState extends Equatable {
  const FoodCreationState();

  @override
  List<Object> get props => [];
}

class FoodCreationInitial extends FoodCreationState {}

class FoodCreationLoading extends FoodCreationState {}

class FoodCreationLoaded extends FoodCreationState {
  final FoodResponse foodData;
  const FoodCreationLoaded({required this.foodData});
   @override
  List<Object> get props => [foodData];
}

class FoodCreationError extends FoodCreationState {
  final String message;
  const FoodCreationError({required this.message});
  @override
  List<Object> get props => [message];
}
