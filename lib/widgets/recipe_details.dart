import 'package:flutter/material.dart';
import 'package:preppa/types/recipe.dart';

class RecipeDetailsWidget extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailsWidget({super.key, required this.recipe});
  final fontWeight = 1.7;

  @override
  Widget build(BuildContext context) {
    TextStyle normalStyle = DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.7);
    TextStyle emphasisStyle = DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0);
    TextStyle grayStyle = normalStyle.apply(color: Colors.grey);
    String needToHave = recipe.needToHave.join(', ');

    //TODO: Background color and make pretty
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Top row should be a bit heavier than the rest
        Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text(recipe.description, style: emphasisStyle,), Text('Cuisine: ${recipe.cuisine}', style: grayStyle)])
        ),
        // Next row is a few details
        Container(
          margin: const EdgeInsets.only(top: 24),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Text('Cooking time roughly ${recipe.cookingTimeMin} min', style: normalStyle),
            const Text('|'),
            Text('Serves ${recipe.servings} people', style: normalStyle),
            const Text('|'),
            Text('Need to have: $needToHave', style: normalStyle),])
        ),
        const Divider(),
        // Ingredients list and image
        Container(
          margin: const EdgeInsets.only(top: 18, left: 9, right: 9),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            //Split the rest in two columns
            children: [
              // Left column
              Flexible(
                flex: 50,
                child: BulletList(strings: recipe.getHumanIngredients(), textStyle: normalStyle)
              ),
              // Right column
              Flexible(
                  flex: 50,
                  //TODO; Make the corners soft
                  child: recipe.loadImage()
              )
            ])
        ),
        NumberedList(strings: recipe.steps, textStyle: normalStyle)
        // Cooking steps
          ]);
  }
}

class NumberedList extends StatelessWidget {
  final List<String> strings;
  final TextStyle textStyle;

  NumberedList({required this.strings, required this.textStyle, super.key});

  @override
  Widget build(BuildContext context) {
    int stepCount = 0;
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          stepCount++;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$stepCount.',style: textStyle),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                    str,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: textStyle
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> strings;
  final TextStyle textStyle;

  BulletList({required this.strings, required this.textStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\u2022',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  str,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: textStyle
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}