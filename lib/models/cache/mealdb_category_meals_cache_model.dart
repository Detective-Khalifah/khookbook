import "package:hive_ce_flutter/hive_flutter.dart";
import "package:khookbook/models/meals_list_model.dart";

class MealDBCategoryMealsCache extends HiveObject {
  final String categoryId;

  final List<MealDBCategoryMealData> meals;

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

class MealDBCategoryMealData {
  final String id;

  final String name;

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
