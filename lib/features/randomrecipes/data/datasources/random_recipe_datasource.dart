import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:usiiname/features/randomrecipes/data/exceptions/exceptions.dart';
import 'package:usiiname/features/randomrecipes/data/models/random_recipe_model.dart';

abstract class RemoteRandomRecipe {
  Future<RandomRecipes> getRandomRecipe({required String mealType});
}

class RemoteRandomRecipeImpl implements RemoteRandomRecipe {
  final client = http.Client();
  //final apiKey = dotenv.env['APIKEY'];
  @override
  Future<RandomRecipes> getRandomRecipe({required String mealType}) async {
    final response = await client.get(Uri.parse(
        'https://api.spoonacular.com/recipes/random?number=30&tags=$mealType&apiKey=dae307428d224c6b9505dfc1c2088630'));

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      var responseBody = json.decode(response.body);
      print(responseBody);
      return RandomRecipes.fromJson(responseBody);
    }
  }
}
