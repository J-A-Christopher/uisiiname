import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:usiiname/features/randomrecipes/domain/entities/random_recipe_ent.dart';
import 'package:usiiname/features/randomrecipes/domain/failure/failures.dart';
import 'package:usiiname/features/randomrecipes/domain/usecases/randomrecipe_usecase.dart';
part 'random_recipes_event.dart';
part 'random_recipes_state.dart';

class RandomRecipesBloc extends Bloc<RandomRecipesEvent, RandomRecipesState> {
  RandomRecipesBloc() : super(RandomRecipesInitial()) {
    final useCases = RandomUsecase();
    on<GetRandomRecipes>((event, emit) async {
      emit(RandomRecipesInitial());
      emit(RandomRecipesLoading());
      final message = await useCases.getRandomRecipe(mealType: event.meal);

      String _mapFailureToMessage(Failure failure) {
        switch (failure.runtimeType) {
          case ServerFailure:
            return 'Server failure try again later';
          case GeneralFailure:
            return 'Something went wrong. Are you online?';
          default:
            return 'Something went wrong. Try again later';
        }
      }

      message.fold(
          (fail) =>
              emit(RandomRecipesError(message: _mapFailureToMessage(fail))),
          (rRecipe) => emit(RandomRecipesLoaded(message: rRecipe)));
    });
  }
}
