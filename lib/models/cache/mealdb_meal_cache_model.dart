import "package:hive_ce_flutter/hive_flutter.dart";

import "package:khookbook/models/meal_model.dart";

part "mealdb_meal_cache_model.g.dart";

@HiveType(typeId: 5)
class MealDBMealCache extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? category;

  @HiveField(3)
  final String instructions;

  @HiveField(4)
  final String thumbnailUrl;

  @HiveField(5)
  final List<String?> ingredients;

  @HiveField(6)
  final List<String?> measures;

  @HiveField(7)
  final String? area;

  @HiveField(8)
  final String? tags;

  @HiveField(9)
  final String? youtubeUrl;

  @HiveField(10)
  final String? source;

  @HiveField(11)
  final DateTime cachedAt;

  @HiveField(12)
  bool? containsHaramIngredients;

  MealDBMealCache({
    required this.id,
    required this.name,
    this.category,
    required this.instructions,
    required this.thumbnailUrl,
    required this.ingredients,
    required this.measures,
    this.area,
    this.tags,
    this.youtubeUrl,
    required this.source,
    required this.cachedAt,
    this.containsHaramIngredients,
  });

  /// Create from MealDB JSON
  factory MealDBMealCache.fromMealDB(Map<String, dynamic> json) {
    List<String> extractIngredients(Map<String, dynamic> json) {
      return List.generate(20, (i) {
        final ing = json["strIngredient${i + 1}"];
        return ing != null && ing.toString().trim().isNotEmpty
            ? ing.toString().trim()
            : "";
      }).where((e) => e.isNotEmpty).toList();
    }

    List<String> extractMeasures(Map<String, dynamic> json) {
      return List.generate(20, (i) {
        final measure = json["strMeasure${i + 1}"];
        return measure != null && measure.toString().trim().isNotEmpty
            ? measure.toString().trim()
            : "";
      }).where((e) => e.isNotEmpty).toList();
    }

    return MealDBMealCache(
      id: json["idMeal"],
      name: json["strMeal"],
      category: json["strCategory"],
      instructions: json["strInstructions"],
      thumbnailUrl: json["strMealThumb"],
      ingredients: extractIngredients(json),
      measures: extractMeasures(json),
      source: json["strSource"],
      area: json["strArea"] as String?,
      tags: json["strTags"] as String?,
      youtubeUrl: json["strYoutube"] as String?,
      cachedAt: DateTime.now(),
    );
  }

  /// Convert from [Meal] model
  factory MealDBMealCache.fromMeal(Meal meal) {
    return MealDBMealCache(
      id: meal.id,
      name: meal.name,
      category: meal.category,
      instructions: meal.instructions,
      thumbnailUrl: meal.thumbnailUrl,
      ingredients: meal.ingredients,
      measures: meal.measures,
      area: meal.area,
      tags: meal.tags,
      youtubeUrl: meal.youtubeUrl,
      source: meal.source,
      cachedAt: DateTime.now(),
    );
  }
}
