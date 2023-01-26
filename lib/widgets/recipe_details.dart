import 'package:flutter/material.dart';
import 'package:preppa/types/recipe.dart';

class RecipeDetailsWidget extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailsWidget({super.key, required this.recipe});
  final fontWeight = 1.7;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = DefaultTextStyle.of(context).style.apply(fontSizeFactor: fontWeight);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(flex: 2, child: Text(recipe.description, style: textStyle,)), Expanded(flex: 4, child: Text('${recipe.cuisine} cuisine.', style: textStyle))]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(flex: 2, child: Text('Approximate cooking time: ${recipe.cookingTimeMin} min.', style: textStyle)), Expanded(flex: 4, child: Text('Serves: ${recipe.servings} people.', style: textStyle))],)
      ],
    );
  }
}