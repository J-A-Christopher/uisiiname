import 'package:dartz/dartz.dart';
import 'package:usiiname/features/randomrecipes/domain/entities/random_recipe_ent.dart';
import 'package:usiiname/features/randomrecipes/domain/failure/failures.dart';

abstract class RandomRepo {
  Future<Either<Failure, RandomRecipeEnt>> getRandomRecipe(
      {required String mealType});
}
