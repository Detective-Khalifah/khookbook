import "package:flutter/material.dart" show BuildContext;
import "package:flutter/foundation.dart" show debugPrint;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/data/recipes_repository.dart";
import "package:khookbook/models/cache/mealdb_category_cache_model.dart"
    show MealDBCategoryCache;
import "package:khookbook/models/cache/mealdb_category_meals_cache_model.dart"
    show MealDBCategoryMealsCache;
import "package:khookbook/models/category_list_model.dart";
import "package:khookbook/models/cache/mealdb_meal_cache_model.dart"
    show MealDBMealCache;
import "package:khookbook/models/meals_list_model.dart";
import "package:khookbook/models/meal_model.dart";
import "package:khookbook/utilities/network/network_loader.dart";

// 1. Repository provider (implements HTTP + cache)
// final recipesRepoProvider = Provider<RecipesRepository>((ref) {
//   return NetworkAndCacheRecipesRepository();
// });
final recipesRepositoryProvider = Provider<RecipesRepository>((ref) {
  final mealdbBox = Hive.isBoxOpen("mealdb_meals")
      ? Hive.box<MealDBMealCache>("mealdb_meals")
      : throw HiveError("Box \"mealdb_meals\" is not open");
  final categoryMealsBox = Hive.isBoxOpen("mealdb_specific_categories")
      ? Hive.box<MealDBCategoryMealsCache>("mealdb_specific_categories")
      : throw HiveError("Box \"mealdb_specific_categories\" is not open");
  final categoriesBox = Hive.isBoxOpen("mealdb_categories")
      ? Hive.box<MealDBCategoryCache>("mealdb_categories")
      : throw HiveError("Box \"mealdb_categories\" is not open");
  return NetworkRecipesRepository(mealdbBox, categoryMealsBox, categoriesBox);
});

// final recipesNotifierProvider =
//     StateNotifierProvider<RecipesNotifier, RecipesRepository>((ref) {
//       final mealdbBox = !Hive.isBoxOpen("mealdb_meals")
//           ? Hive.box<MealDBMealCache>("mealdb_meals")
//           : throw HiveError("Box \"mealdb_recipes\" is not open");
//       final categoryMealsBox = !Hive.isBoxOpen("mealdb_specific_categories")
//           ? Hive.box<MealDBCategoryMealsCache>("mealdb_specific_categories")
//           : throw HiveError("Box \"mealdb_specific_categories\" is not open");
//       final categoriesBox = !Hive.isBoxOpen("mealdb_categories")
//           ? Hive.box<MealDBCategoryCache>("mealdb_categories")
//           : throw HiveError("Box \"mealdb_categories\" is not open");
//       return RecipesNotifier(mealdbBox, categoryMealsBox, categoriesBox);
//     });

class RecipesNotifier extends StateNotifier<RecipesRepository> {
  RecipesNotifier(
    Box<MealDBMealCache> mealdbBox,
    Box<MealDBCategoryMealsCache> categoryMealsBox,
    Box<MealDBCategoryCache> categoriesBox,
  ) : super(
        NetworkRecipesRepository(mealdbBox, categoryMealsBox, categoriesBox),
      );

  Future<List<Category>> fetchCategories(BuildContext context) async {
    final result = await executeNetworkOperation<List<Category>>(
      context: context,
      loadingText: "Fetching categories...",
      loader: () => state.fetchAllCategories(context),
      onError: (error) => debugPrint("Error fetching categories: $error"),
    );
    if (result == null) {
      throw Exception("Failed to fetch categories");
    }
    return result;
  }

  Future<List<CategoryMeals>> fetchMealsByCategory(
    BuildContext context,
    String category,
  ) async {
    final result = await executeNetworkOperation<List<CategoryMeals>>(
      context: context,
      loadingText: "Fetching meals...",
      loader: () => state.fetchMealsByCategory(context, category),
      onError: (error) => debugPrint("Error fetching meals: $error"),
    );
    if (result == null) {
      throw Exception("Failed to fetch meals for category: $category");
    }
    return result;
  }

  Future<Meal> fetchMealById(BuildContext context, String id) async {
    final result = await executeNetworkOperation<Meal>(
      context: context,
      loadingText: "Fetching meal details...",
      loader: () => state.fetchMealById(context, id),
      onError: (error) => debugPrint("Error fetching meal: $error"),
    );
    if (result == null) {
      throw Exception("Failed to fetch meal details for ID: $id");
    }
    return result;
  }
}

// Update provider to handle BuildContext properly
final categoriesProvider = FutureProvider.autoDispose
    .family<List<Category>, BuildContext>((ref, context) async {
      final repository = ref.watch(recipesRepositoryProvider);
      return repository.fetchAllCategories(context);
    });

final categoryMealsProvider =
    FutureProvider.family<
      List<CategoryMeals>,
      ({BuildContext context, String category})
    >((ref, params) async {
      final repository = ref.watch(recipesRepositoryProvider);
      return repository.fetchMealsByCategory(params.context, params.category);
    });

final mealDetailProvider =
    FutureProvider.family<Meal, ({BuildContext context, String id})>((
      ref,
      params,
    ) async {
      final repository = ref.watch(recipesRepositoryProvider);
      return repository.fetchMealById(params.context, params.id);
    });
