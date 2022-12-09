import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:preppa/types/recipe.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

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

class _RecipeListState extends State<RecipeList> {
  final _biggerFont = const TextStyle(fontSize: 18);
  late Future<List<Recipe>> futureRecipes;

  @override
  void initState() {
    super.initState();
    futureRecipes = fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
        future: futureRecipes,
        builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget> [
                Container(
                  width: 160.0,
                  color: Colors.red,
                ),
                Container(
                  width: 160.0,
                  color: Colors.blue,
                ),
                Container(
                  width: 160.0,
                  color: Colors.green,
                ),
                Container(
                  width: 160.0,
                  color: Colors.yellow,
                ),
                Container(
                  width: 160.0,
                  color: Colors.orange,
                )]
              );
            },);
        }
        else {
          // While we wait
          return const CircularProgressIndicator();
        }
        });
  }
}
