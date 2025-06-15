import "package:hive_ce_flutter/hive_flutter.dart";
import "package:khookbook/models/meals_list_model.dart";

part "mealdb_category_meals_cache_model.g.dart";

@HiveType(typeId: 3)
class MealDBCategoryMealsCache extends HiveObject {
  @HiveField(0)
  final String categoryId;

  @HiveField(1)
  final List<MealDBCategoryMealData> meals;

  @HiveField(2)
  final DateTime cachedAt;

  MealDBCategoryMealsCache({
    required this.categoryId,
    required this.meals,
    required this.cachedAt,
  });

  /// Convert from [CategoryMealsList] model
  factory MealDBCategoryMealsCache.fromCategoryMealsList(
    String categoryId,
    CategoryMealsList mealsList,
  ) {
    return MealDBCategoryMealsCache(
      categoryId: categoryId,
      meals: mealsList.meals
          .map((meal) => MealDBCategoryMealData.fromCategoryMeal(meal))
          .toList(),
      cachedAt: DateTime.now(),
    );
  }

  CategoryMealsList toCategoryMealsList() {
    return CategoryMealsList(
      meals: meals.map((mealData) => mealData.toCategoryMeal()).toList(),
    );
  }
}

@HiveType(typeId: 4)
class MealDBCategoryMealData {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String thumbnailUrl;

  MealDBCategoryMealData({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
  });

  /// Convert from [CategoryMeals] model
  factory MealDBCategoryMealData.fromCategoryMeal(CategoryMeals meal) {
    return MealDBCategoryMealData(
      id: meal.id,
      name: meal.name,
      thumbnailUrl: meal.thumbnailUrl,
    );
  }

  CategoryMeals toCategoryMeal() {
    return CategoryMeals(id: id, name: name, thumbnailUrl: thumbnailUrl);
  }
}
