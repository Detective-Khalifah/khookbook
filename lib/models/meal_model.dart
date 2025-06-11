class Meal {
  final String id;
  final String instructions;
  final String name;
  final String thumbnailUrl;
  final String? area, category, source, tags, youtubeUrl;

  // Instead of ingredient1…ingredient20 + measure1…measure20:
  final List<String?> ingredients;
  final List<String?> measures;

  Meal({
    required this.id,
    required this.instructions,
    required this.name,
    required this.thumbnailUrl,
    this.area,
    this.category,
    this.source,
    this.tags,
    this.youtubeUrl,
    required this.ingredients,
    required this.measures,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    // Dynamically collect the 20 pairs
    final ingredients = List<String?>.generate(
        20, (i) => json['strIngredient${i + 1}'] as String?);
    final measures = List<String?>.generate(
        20, (i) => json['strMeasure${i + 1}'] as String?);
    return Meal(
      id: json['idMeal'] as String,
      instructions: json['strInstructions'] as String,
      name: json['strMeal'] as String,
      thumbnailUrl: json['strMealThumb'] as String,
      area: json['strArea'] as String?,
      category: json['strCategory'] as String?,
      source: json['strSource'] as String?,
      tags: json['strTags'] as String?,
      youtubeUrl: json['strYoutube'] as String?,
      ingredients: ingredients,
      measures: measures,
    );
  }
}

extension MealIngredients on Meal {
  /// Returns list of “Ingredient (Measure)” pairs, skipping empties.
  List<String> get ingredientPairs {
    final pairs = <String>[];
    for (var i = 0; i < ingredients.length; i++) {
      final ing = ingredients[i]?.trim();
      final meas = measures[i]?.trim();
      if (ing != null && ing.isNotEmpty) {
        pairs.add(meas != null && meas.isNotEmpty ? '$ing ($meas)' : ing);
      }
    }
    return pairs;
  }
}

class MealSpecs {
  final List<Meal> meals;
  MealSpecs(this.meals);

  factory MealSpecs.fromJson(Map<String, dynamic> json) => MealSpecs(
        (json['meals'] as List)
            .map((e) => Meal.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
