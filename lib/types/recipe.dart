class Recipe {
  final String description;

  const Recipe({
    required this.description
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      description: json['description'],
    );
  }
}