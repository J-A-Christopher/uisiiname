part of 'random_recipes_bloc.dart';

abstract class RandomRecipesEvent extends Equatable {
  const RandomRecipesEvent();

  @override
  List<Object> get props => [];
}

class GetRandomRecipes extends RandomRecipesEvent {
  final String meal;

  const GetRandomRecipes({required this.meal});

  @override
  List<Object> get props => [meal];
}
