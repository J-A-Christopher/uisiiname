import 'package:dartz/dartz.dart';
import 'package:usiiname/features/randomrecipes/data/repositories/random_recipe_repo_impl.dart';
import 'package:usiiname/features/randomrecipes/domain/entities/random_recipe_ent.dart';
import 'package:usiiname/features/randomrecipes/domain/failure/failures.dart';

class RandomUsecase {
  Future<Either<Failure, RandomRecipeEnt>> getRandomRecipe(
      {required String mealType}) async {
    final randomUseCases = RandomRepoImpl();
    final result = await randomUseCases.getRandomRecipe(mealType: mealType);
    return result;
    //return left(GeneralFailure());
  }
}
