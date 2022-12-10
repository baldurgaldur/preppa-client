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
    print("Description");
    print(json['description']);
    print(json['cuisine']);
    print(json['name']);
    print(json['cooking_time_min']);

    return Recipe(
        description: json['description'],
        cuisine: json['cuisine'],
        name: json['name'],
        cookingTimeMin: json['cooking_time_min']
    );
  }
}