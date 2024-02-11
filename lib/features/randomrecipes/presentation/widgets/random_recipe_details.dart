import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:usiiname/components/food_tile.dart';
import 'package:usiiname/features/randomrecipes/presentation/bloc/random_recipes_bloc.dart';

class RandomRecipeDetails extends StatelessWidget {
  final int? id;
  final String? title;
  const RandomRecipeDetails({super.key, required this.id, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              '$title',
              style: const TextStyle(color: Colors.black),
            ),
            elevation: 0,
            leading: GestureDetector(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )),
        body: BlocBuilder<RandomRecipesBloc, RandomRecipesState>(
            builder: (context, state) {
          if (state is RandomRecipesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is RandomRecipesLoaded) {
            final randRec =
                state.message.recipes?.firstWhere((recipe) => recipe.id == id);
            final mediaQuery = MediaQuery.of(context).size;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Image.network(
                    '${randRec?.image}',
                    height: mediaQuery.height * .6,
                    fit: BoxFit.cover,
                  ),
                  Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: FoodTitle(
                                        foodTitle: '${randRec?.title}')),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Text('Likes: '),
                                      const Icon(
                                        Icons.favorite,
                                        color: Color(0xffffa500),
                                      ),
                                      Text('${randRec?.aggregateLikes}'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        const Icon(Icons.schedule),
                                        Text(
                                            'Ready in : ${randRec?.readyInMinutes} minutes')
                                      ],
                                    )),
                                Expanded(
                                    child: Row(
                                  children: [
                                    const Icon(Icons.health_and_safety),
                                    Text('Health: ${randRec?.healthScore}')
                                  ],
                                )),
                                Expanded(
                                    child: Row(
                                  children: [
                                    const Icon(Icons.paid),
                                    Text('${randRec?.pricePerServing}sh')
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const FoodTitle(foodTitle: 'Instructions'),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              Bidi.stripHtmlIfNeeded(
                                '${randRec?.instructions}',
                              ),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 17),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const FoodTitle(foodTitle: 'Summary of the dish'),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              Bidi.stripHtmlIfNeeded(
                                '${randRec?.summary}',
                              ),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 17),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        }));
  }
}
