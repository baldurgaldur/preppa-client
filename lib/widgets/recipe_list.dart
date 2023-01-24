import 'package:flutter/material.dart';
import 'package:preppa/types/recipe.dart';

class RecipeListWidget extends StatelessWidget {

  final List<Recipe> recipeList;
  final Function recipeClick;
  const RecipeListWidget({
    super.key, required this.recipeList, required this.recipeClick
  });

  final String baseThumbnailUrl = "https://raw.githubusercontent.com/baldurgaldur/preppa-server/main/static/images/";

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 106.0,
      itemCount: recipeList.length,
      itemBuilder: (context, index) {
        Recipe recipe = recipeList[index];
        final String recipeName = recipe.name ?? "";
        final String imgUrl = "$baseThumbnailUrl$recipeName.jpg";

        Image recImage = Image(
            image: NetworkImage(imgUrl)
        );
        return InkWell(
            onTap: recipeClick(),
            child:  CustomListItem(
              description: recipe.description,
              thumbnail: recImage,
              cookingTimeMin: recipe.cookingTimeMin,
              cuisine: recipe.cuisine,
            ),
        );
      },
    );
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