import 'package:flutter/cupertino.dart';

class Recipe {
  final String description;
  final String cuisine;
  final String name;
  final int cookingTimeMin;
  final int servings;
  final List<String> needToHave;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> units;
  final List<String> amounts;
  final List<String> tools;

  final String baseImgUrl = "https://raw.githubusercontent.com/baldurgaldur/preppa-server/main/static/images/";

  const Recipe({
    required this.description,
    required this.cuisine,
    required this.name,
    required this.cookingTimeMin,
    required this.servings,
    required this.needToHave,
    required this.ingredients,
    required this.steps,
    required this.units,
    required this.amounts,
    required this.tools
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {

    return Recipe(
        description: json['description'],
        cuisine: json['cuisine'],
        name: json['name'],
        cookingTimeMin: json['cooking_time_min'],
        servings: json['serves'],
        needToHave: json['need_to_have'],
        ingredients: json['ingredients'],
        units: json['units'],
        amounts: json['amounts'],
        steps: json['steps'],
        tools: json['tools']
    );
  }

  List<String> getHumanIngredients() {
    List<String> humanIngredients = [];
    for(int i=0;i<ingredients.length;i++) {
      humanIngredients.add('${amounts[i]}${units[i]} ${ingredients[i]}');
    }
    return humanIngredients;
  }

  Image loadImage() {
    final String imgUrl = "$baseImgUrl$name.jpg";
    return Image(
        image: NetworkImage(imgUrl)
    );

  }
}