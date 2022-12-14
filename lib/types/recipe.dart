class Recipe {
  final String description;
  final String cuisine;
  final String name;
  final int cookingTimeMin;

  const Recipe({
    required this.description,
    required this.cuisine,
    required this.name,
    required this.cookingTimeMin
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {

    return Recipe(
        description: json['description'],
        cuisine: json['cuisine'],
        name: json['name'],
        cookingTimeMin: json['cooking_time_min']
    );
  }
}