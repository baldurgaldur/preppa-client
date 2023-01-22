import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:preppa/types/recipe.dart';


Future<List<Recipe>> fetchRecipes() async {
  final response = await http
      .get(Uri.parse('https://preppa-server.fly.dev/recipes'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Iterable l = json.decode(response.body);
    List<Recipe> recipes = List<Recipe>.from(l.map((model)=> Recipe.fromJson(model)));

    return recipes;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load recipes');
  }
}