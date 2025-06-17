import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart" show Box;
import "package:khookbook/models/cache/mealdb_category_cache_model.dart";
import "package:khookbook/models/cache/mealdb_category_meals_cache_model.dart";
import "package:khookbook/models/cache/mealdb_meal_cache_model.dart";
import "package:khookbook/services/network_fetcher.dart";
import "package:khookbook/models/category_list_model.dart";
import "package:khookbook/models/meals_list_model.dart";
import "package:khookbook/models/meal_model.dart";
import "package:khookbook/utilities/network/network_loader.dart";

/// Abstract class defining the contract for a recipes repository.
/// This allows for different implementations (e.g., network-only, network-with-cache).
abstract class RecipesRepository {
  /// Fetches a list of all meal categories.
  Future<List<Category>> fetchAllCategories(BuildContext context);

  /// Fetches a list of meals belonging to a specific [Category].
  Future<List<CategoryMeals>> fetchMealsByCategory(
    BuildContext context,
    String category,
  );

  /// Fetches the details of a specific [Meal] by its ID.
  Future<Meal> fetchMealById(BuildContext context, String id);
}

/// Implementation of [RecipesRepository] that fetches data from the network
/// and utilizes a local cache ([Hive]) to store and retrieve meal details.
class MealDBRecipesRepository implements RecipesRepository {
  // Service for making network requests.
  final _fetcher = NetworkFetcher();

  // Hive box for caching meal data.
  final Box<MealDBMealCache> _mealBox;
  final Box<MealDBCategoryMealsCache> _categoryMealsBox;
  final Box<MealDBCategoryCache> _categoriesBox;

  // Key for caching all categories.
  // This is used to store and retrieve the list of all categories.
  static const String categoriesKey = "all_categories";
  static const String categoryMealsPrefix = "category_meals_";

  MealDBRecipesRepository(
    this._mealBox,
    this._categoryMealsBox,
    this._categoriesBox,
  );

  @override
  Future<List<Category>> fetchAllCategories(BuildContext context) async {
    // final cacheKey = categoriesKey;
    return await executeMealDBOperation<List<Category>>(
      context: context,
      loadingText: "Fetching categories...",
      loader: () async {
        // Fetches category data from TheMealDB API.
        final result = await _fetcher.fetchJSONData(
          "https://www.themealdb.com/api/json/v1/1/categories.php",
        );

        if (result.isError) {
          throw Exception(result.error);
        }

        final categoriesList = CategoriesList.fromJson(result.data!);
        // Cache the categories list
        await _categoriesBox.put(
          categoriesKey,
          MealDBCategoryCache.fromCategoriesList(categoriesList),
        );

        return categoriesList.categories;
      },
      cacheLoader: () async {
        final cached = _categoriesBox.get(categoriesKey);
        if (cached != null) {
          return cached.toCategoriesList().categories;
        }
        return null;
      },
    );
  }

  @override
  Future<List<CategoryMeals>> fetchMealsByCategory(
    BuildContext context,
    String category,
  ) async {
    final cacheKey = "$categoryMealsPrefix$category";
    return await executeMealDBOperation<List<CategoryMeals>>(
      context: context,
      loadingText: "Fetching meals...",
      loader: () async {
        // Fetches meals for a given category from TheMealDB API.
        final result = await _fetcher.fetchJSONData(
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category",
        );

        if (result.isError) {
          throw Exception(result.error);
        }

        final mealsList = CategoryMealsList.fromJson(result.data!);
        // Cache the meals list
        await _categoryMealsBox.put(
          cacheKey,
          MealDBCategoryMealsCache.fromCategoryMealsList(category, mealsList),
        );

        return mealsList.meals;
      },

      cacheLoader: () async {
        // Attempt to load meals from cache
        final cached = _categoryMealsBox.get(cacheKey);
        if (cached != null) {
          return cached.toCategoryMealsList().meals;
        }
        return null;
      },
    );
  }

  @override
  Future<Meal> fetchMealById(BuildContext context, String id) async {
    return await executeMealDBOperation<Meal>(
      context: context,
      loadingText: "Fetching recipe details...",
      loader: () async {
        // Fetches the details of a specific meal by its ID from TheMealDB API.
        final result = await _fetcher.fetchJSONData(
          "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id",
        );

        if (result.isError) {
          throw Exception(result.error);
        }

        final meal = MealSpecs.fromJson(result.data!).meals.first;
        // Cache the meal
        await _mealBox.put(id, MealDBMealCache.fromMeal(meal));
        return meal;
      },
      cacheLoader: () async {
        final cached = _mealBox.get(id);
        if (cached != null) {
          return Meal(
            id: cached.id,
            name: cached.name,
            instructions: cached.instructions,
            thumbnailUrl: cached.thumbnailUrl,
            ingredients: cached.ingredients,
            measures: cached.measures,
            area: cached.area,
            category: cached.category,
            source: cached.source,
            tags: cached.tags,
            youtubeUrl: cached.youtubeUrl,
          );
        }
        return null;
      },
    );
  }
}
