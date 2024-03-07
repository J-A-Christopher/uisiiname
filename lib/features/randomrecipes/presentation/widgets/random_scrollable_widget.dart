import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usiiname/components/food_tile.dart';
import 'package:usiiname/components/meal_detail.dart';
import 'package:usiiname/features/randomrecipes/presentation/bloc/random_recipes_bloc.dart';
import 'package:usiiname/features/randomrecipes/presentation/widgets/random_recipe_details.dart';

class RandomScrollableWidget extends StatelessWidget {
  const RandomScrollableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<RandomRecipesBloc, RandomRecipesState>(
        builder: (context, state) {
          if (state is RandomRecipesLoaded) {
            final recipe = state.message.recipes;
            final mediaQuery = MediaQuery.of(context).size;
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Wrap(
                spacing: 10,
                children: recipe != null
                    ? List.generate(recipe.length, (index) {
                        return SizedBox(
                          height: mediaQuery.height * 0.45,
                          width: mediaQuery.width * 0.35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  final clickedRandomRecipe = recipe[index].id;
                                  final clickedRandomRecipeTitle =
                                      recipe[index].title;
                                  print(clickedRandomRecipe);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<
                                                RandomRecipesBloc>(context),
                                            child: RandomRecipeDetails(
                                                id: clickedRandomRecipe,
                                                title:
                                                    clickedRandomRecipeTitle),
                                          )));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    '${recipe[index].image}',
                                    fit: BoxFit.cover,
                                    height: mediaQuery.height * 0.28,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: FoodTitle(
                                    foodTitle: '${recipe[index].title}'),
                              ),
                              MealDetails(details: '${recipe[index].title}'),
                              MealDetails(
                                  details:
                                      'Time: ${recipe[index].readyInMinutes} mins')
                            ],
                          ),
                        );
                      })
                    : List.empty(),
              ),
            );
          }
          return const Center();
        },
      ),
    );
  }
}
