import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usiiname/components/categories_widget.dart';
import 'package:usiiname/components/sub_section.dart';
import 'package:usiiname/features/randomrecipes/presentation/bloc/random_recipes_bloc.dart';
import 'package:usiiname/features/randomrecipes/presentation/widgets/random_recipes_widget.dart';

class RandomRec extends StatefulWidget {
  const RandomRec({super.key});

  @override
  State<RandomRec> createState() => _RandomRecState();
}

class _RandomRecState extends State<RandomRec> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Find Recipes',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocProvider(
          create: (_) => RandomRecipesBloc(),
          child: const Column(
            children: [
              //SubSection(heading: 'Find Recipes For The Following Categories'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CategoriesWidget(),
              ),
              SizedBox(
                height: 35,
              ),
              SubSection(heading: 'Random Recipes'),
              RandomRecipesWidget()
            ],
          ),
        ),
      ),
    );
  }
}
