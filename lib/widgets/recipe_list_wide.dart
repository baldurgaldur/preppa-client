import 'package:flutter/material.dart';
import 'package:preppa/types/recipe.dart';
import 'package:preppa/widgets/recipe_list.dart';

class WideRecipeListWidget extends StatefulWidget {
  final List<Recipe> recipeList;
  const WideRecipeListWidget({super.key, required this.recipeList});

  @override
  State<StatefulWidget> createState() => _WideRecipeListWidgetState();
}

class _WideRecipeListWidgetState extends State<WideRecipeListWidget> {

  int chosenRecipe = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
              flex: 2,
              child: RecipeListWidget(recipeList: widget.recipeList, recipeClick: () {
                  chosenRecipe=1;
                })),
          Expanded(
              flex: 3,
              child: Text('Recipe index is $chosenRecipe')
          )
        ]);
  }
}