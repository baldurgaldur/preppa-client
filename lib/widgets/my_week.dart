import 'package:flutter/material.dart';
import 'package:preppa/types/recipe.dart';

import 'package:preppa/network/recipe_api.dart';
import 'package:preppa/widgets/recipe_list.dart';

class MyWeekWidget extends StatefulWidget {
  const MyWeekWidget({super.key});

  @override
  State<StatefulWidget> createState() => _MyWeekWidgetState();
}

class _MyWeekWidgetState extends State<MyWeekWidget> {
  late Future<List<Recipe>> futureRecipes;
  final String baseThumbnailUrl = "https://raw.githubusercontent.com/baldurgaldur/preppa-server/main/static/images/";

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
            List<Recipe> recipeList = snapshot.data ?? [];
            return LayoutBuilder(builder: (context, constraints) {
              if(constraints.maxWidth < 600) {
                // Thin screen can only show list. Clicking on a recipe will push the whole recipe onto the screen
                return RecipeListWidget(recipeList: recipeList);
              } else {
                // Wide screen can show both list and recipe to the right. Clicking on a recipe will show the recipe on the right
                return Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: RecipeListWidget(recipeList: recipeList)),
                      const Expanded(
                          flex: 3,
                          //TODO: Add widget for the recipe-details here.
                          //TODO: It should support adding all ingredients to shopping list
                          child: Placeholder()
                      )
                    ]);
              }
            });
          } else {
            // While we wait
            return const CircularProgressIndicator();
          }
        });
  }
}