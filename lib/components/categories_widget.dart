import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usiiname/components/meal_detail.dart';
import 'package:usiiname/features/randomrecipes/presentation/bloc/random_recipes_bloc.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> mealNames = [
      'breakfast',
      'lunch',
      'dinner',
      'dessert',
      'drinks',
      'junks'
    ];
    List<String> imageNames = [
      'breakfast',
      'lunch',
      'supper',
      'cakeslice',
      'coffee',
      'frenchfries',
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Wrap(
        spacing: 10,
        children: List.generate(mealNames.length, (index) {
          return GestureDetector(
            onTap: () {
              context
                  .read<RandomRecipesBloc>()
                  .add(GetRandomRecipes(meal: mealNames[index]));
            },
            child: Container(
              height: 80,
              width: 90,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/${imageNames[index]}.png',
                      height: 40,
                    ),
                  ),
                  MealDetails(details: mealNames[index]),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
