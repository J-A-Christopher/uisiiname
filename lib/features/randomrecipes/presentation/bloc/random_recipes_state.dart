part of 'random_recipes_bloc.dart';

abstract class RandomRecipesState extends Equatable {
  const RandomRecipesState();

  @override
  List<Object> get props => [];
}

class RandomRecipesInitial extends RandomRecipesState {}

class RandomRecipesLoading extends RandomRecipesState {}

class RandomRecipesLoaded extends RandomRecipesState {
  final RandomRecipeEnt message;
  const RandomRecipesLoaded({required this.message});
}

class RandomRecipesError extends RandomRecipesState {
  final String message;
  const RandomRecipesError({required this.message});

  @override
  List<Object> get props => [message];
}
