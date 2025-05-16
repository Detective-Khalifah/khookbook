import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khookbook/data/recipes_repository.dart';
import 'package:khookbook/models/category_list_model.dart';
import 'package:khookbook/models/meals_list_model.dart';
import 'package:khookbook/models/meal_model.dart';

// 1. Repository provider (implements HTTP + cache)
// final recipesRepoProvider = Provider<RecipesRepository>((ref) {
//   return NetworkAndCacheRecipesRepository();
// });
final recipesRepositoryProvider =
    Provider<RecipesRepository>((ref) => NetworkRecipesRepository());

final categoriesProvider = FutureProvider.autoDispose<List<Category>>((ref) {
  return ref.read(recipesRepositoryProvider).fetchAllCategories();
});

// 2. All recipes in a category (List<MealSummary>)
// final categoryMealsProvider =
//     FutureProvider.family<List<Recipe>, String>((ref, category) {
//   return ref.read(recipesRepoProvider).fetchMealsByCategory(category);
// });
final categoryMealsProvider =
    FutureProvider.family<List<CategoryMeals>, String>((ref, category) {
  return ref.read(recipesRepositoryProvider).fetchMealsByCategory(category);
});

// 3. Single meal by detail - `Meal` - by ID
// final mealDetailProvider = FutureProvider.family<Recipe, String>((ref, id) {
//   return ref.read(recipesRepoProvider).fetchMealById(id);
// });
final mealDetailProvider = FutureProvider.family<Meal, String>((ref, id) {
  return ref.read(recipesRepositoryProvider).fetchMealById(id);
});
