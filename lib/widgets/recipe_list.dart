import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:preppa/types/recipe.dart';

class ThinWeek extends StatefulWidget {
  const ThinWeek({super.key});

  @override
  State<ThinWeek> createState() => _ThinWeekState();
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

class _RecipeDescription extends StatelessWidget {
  const _RecipeDescription({
    required this.description,
    required this.cookingTimeMin,
    required this.cuisine,
  });

  final String description;
  final String cuisine;
  final int cookingTimeMin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            description,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            cuisine,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            '$cookingTimeMin minutes',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.thumbnail,
    required this.description,
    required this.cuisine,
    required this.cookingTimeMin,
  });

  final Widget thumbnail;
  final String description;
  final String cuisine;
  final int cookingTimeMin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: _RecipeDescription(
              description: description,
              cuisine: cuisine,
              cookingTimeMin: cookingTimeMin,
            ),
          ),
          const Icon(
            Icons.more_vert,
            size: 16.0,
          ),
        ],
      ),
    );
  }
}

class _ThinWeekState extends State<ThinWeek> {
  late Future<List<Recipe>> futureRecipes;
  final String baseThumbnailUrl = "https://raw.githubusercontent.com/baldurgaldur/preppa-server/main/static/images/";

  @override
  void initState() {
    super.initState();
    futureRecipes = fetchRecipes();
  }

  List<Widget> mapToWidget(List<Recipe> recipes) {
    List<Widget> resp = [];
    for (var i =0; i< recipes.length;i++) {
      Recipe recipe = recipes[i];
      final String recipeName = recipe.name ?? "";
      final String imgUrl = "$baseThumbnailUrl$recipeName.jpg";

      Image recImage = Image(
        image: NetworkImage(imgUrl)
      );
      resp.add(CustomListItem(
        description: recipe.description,
        thumbnail: recImage,
        cookingTimeMin: recipe.cookingTimeMin,
        cuisine: recipe.cuisine,
      ));
    }
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
        future: futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              return ListView(
                padding: const EdgeInsets.all(8.0),
                itemExtent: 106.0,
                children: mapToWidget(snapshot.data ?? [])
              );
            }
          else {
          // While we wait
          return const CircularProgressIndicator();
        }
        });
  }
}

//Wide version of the week widget
class WideWeek extends StatefulWidget {
  const WideWeek({super.key});

  @override
  State<WideWeek> createState() => _WideWeekState();
}

class _WideWeekState extends State<WideWeek> {
  late Future<List<Recipe>> futureRecipes;
  final String baseThumbnailUrl = "https://raw.githubusercontent.com/baldurgaldur/preppa-server/main/static/images/";

  @override
  void initState() {
    super.initState();
    futureRecipes = fetchRecipes();
  }

  List<Widget> mapToWidget(List<Recipe> recipes) {
    List<Widget> resp = [];
    for (var i =0; i< recipes.length;i++) {
      Recipe recipe = recipes[i];
      final String recipeName = recipe.name ?? "";
      final String imgUrl = "$baseThumbnailUrl$recipeName.jpg";

      Image recImage = Image(
          image: NetworkImage(imgUrl)
      );
      resp.add(CustomListItem(
        description: recipe.description,
        thumbnail: recImage,
        cookingTimeMin: recipe.cookingTimeMin,
        cuisine: recipe.cuisine,
      ));
    }
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
        future: futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView(
                            padding: const EdgeInsets.all(8.0),
                            itemExtent: 106.0,
                            children: mapToWidget(snapshot.data ?? []))),
                  const Expanded(
                    flex: 3,
                    child: Placeholder()
                  )
            ]);
          }
          else {
            // While we wait
            return const CircularProgressIndicator();
          }
        });
  }
}
