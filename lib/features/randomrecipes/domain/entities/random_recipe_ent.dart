import 'package:equatable/equatable.dart';
import 'package:usiiname/features/randomrecipes/data/models/random_recipe_model.dart';


class RandomRecipeEnt extends Equatable {
  final List<Recipes>? recipes;

  const RandomRecipeEnt({
    this.recipes,
  });
  // final String name;
  // const RandomRecipeEnt({required this.name});

  @override
  List<Object?> get props => [recipes];
}
