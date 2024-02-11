

import 'package:dartz/dartz.dart';
import 'package:usiiname/features/randomrecipes/data/datasources/random_recipe_datasource.dart';
import 'package:usiiname/features/randomrecipes/data/exceptions/exceptions.dart';
import 'package:usiiname/features/randomrecipes/domain/entities/random_recipe_ent.dart';
import 'package:usiiname/features/randomrecipes/domain/failure/failures.dart';
import 'package:usiiname/features/randomrecipes/domain/repositories/random_repo.dart';

class RandomRepoImpl implements RandomRepo {
  final RemoteRandomRecipe remoteRandomRecipe = RemoteRandomRecipeImpl();
  @override
  Future<Either<Failure, RandomRecipeEnt>> getRandomRecipe(
      {required String mealType}) async {
    try {
      final dataSource =
          await remoteRandomRecipe.getRandomRecipe(mealType: mealType);
      return right(dataSource);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (error) {
      return left(GeneralFailure());
    }
  }
}
