import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart" show Box;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:khookbook/models/cache/mealdb_category_cache_model.dart";
import "package:khookbook/models/cache/mealdb_category_meals_cache_model.dart";
import "package:khookbook/models/cache/mealdb_meal_cache_model.dart";
import "package:khookbook/providers/settings_provider.dart";
import "package:khookbook/services/network_fetcher.dart";
import "package:khookbook/models/category_list_model.dart";
import "package:khookbook/models/meals_list_model.dart";
import "package:khookbook/models/meal_model.dart";
import "package:khookbook/utilities/network/network_loader.dart";
import "package:khookbook/services/halal_verification_service.dart";

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
  final _verifier = HalalVerificationService();

  // Hive box for caching meal data.
  final Box<MealDBMealCache> _mealBox;
  final Box<MealDBCategoryMealsCache> _categoryMealsBox;
  final Box<MealDBCategoryCache> _categoriesBox;
  final Ref? _ref;

  // Key for caching all categories.
  // This is used to store and retrieve the list of all categories.
  static const String categoriesKey = "all_categories";
  static const String categoryMealsPrefix = "category_meals_";

  static const Duration _cacheExpiration = Duration(days: 7);

  MealDBRecipesRepository(
    this._mealBox,
    this._categoryMealsBox,
    this._categoriesBox,
    this._ref,
  ); // Add Ref parameter

  bool _isCacheValid(DateTime? cachedAt) {
    if (cachedAt == null) return false;
    return DateTime.now().difference(cachedAt) < _cacheExpiration;
  }

  @override
  Future<List<Category>> fetchAllCategories(BuildContext context) async {
    final result = await fetchMealDBWithCache<List<Category>>(
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

        // Filter out haram categories like "Pork"
        final filteredCategories = categoriesList.categories
            .where(
              (cat) => !HalalVerificationService.haramIngredients.any(
                (h) =>
                    cat.category?.toLowerCase().contains(h.toLowerCase()) ??
                    false,
              ),
            )
            .toList();

        await _categoriesBox.put(
          categoriesKey,
          MealDBCategoryCache.fromCategoriesList(
            CategoriesList(categories: filteredCategories),
          ),
        );

        return filteredCategories;
      },
      cacheLoader: () async {
        final cached = _categoriesBox.get(categoriesKey);
        return cached?.toCategoriesList().categories;
      },
    );
    if (result.isSuccess || result.isOffline) {
      return result.data!;
    }
    throw Exception(result.error);
  }

  /// Helper method to check meals without throwing exceptions.
  /// Used to pre-filter meals that contain haram ingredients before displaying them.
  /// Returns null if:
  /// - The meal contains haram ingredients (when halal filter is enabled)
  /// - There was an error fetching or processing the meal
  /// - The API response was invalid
  Future<Meal?> fetchMealDetailWithoutException(
    BuildContext context,
    String id,
  ) async {
    try {
      final result = await _fetcher.fetchJSONData(
        "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id",
      );

      if (result.isError) return null;

      final meal = MealSpecs.fromJson(result.data!).meals.first;

      // Check if halal filter is enabled in user settings
      // Falls back to enabled (true) if settings can't be read
      final settings = _ref?.read(settingsProvider);
      if (settings?.halalFilterEnabled ?? true) {
        // Only verify halal status if filter is enabled
        final containsHaram = await _verifier.containsHaramIngredients(
          meal.ingredients.where((i) => i != null).map((i) => i!).toList(),
        );

        // Skip meals with haram ingredients when filter is on
        if (containsHaram) return null;
      }

      // Cache the meal regardless of halal status
      await _mealBox.put(id, MealDBMealCache.fromMeal(meal));
      return meal;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CategoryMeals>> fetchMealsByCategory(
    BuildContext context,
    String category,
  ) async {
    final cacheKey = "$categoryMealsPrefix$category";

    final result = await fetchMealDBWithCache<List<CategoryMeals>>(
      context: context,
      loadingText: "Fetching meals...",
      loader: () async {
        final result = await _fetcher.fetchJSONData(
          "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category",
        );

        if (result.isError) {
          throw Exception(result.error);
        }

        final mealsList = CategoryMealsList.fromJson(result.data!);

        // Check if halal filter is enabled in user settings
        // Falls back to enabled (true) if settings can't be read
        final settings = _ref?.read(settingsProvider);
        final isHalalFilterEnabled = settings?.halalFilterEnabled ?? true;

        final filteredMeals = <CategoryMeals>[];
        for (final meal in mealsList.meals) {
          if (isHalalFilterEnabled) {
            // When halal filter is on, verify each meal's ingredients
            final detailedMeal = await fetchMealDetailWithoutException(
              context,
              meal.id,
            );
            if (detailedMeal != null) {
              // Only include meals that passed halal verification
              filteredMeals.add(meal);
            }
          } else {
            // When halal filter is off, include all meals without checking
            filteredMeals.add(meal);
          }
        }

        // Cache the filtered results
        await _categoryMealsBox.put(
          cacheKey,
          MealDBCategoryMealsCache.fromCategoryMealsList(
            category,
            CategoryMealsList(meals: filteredMeals),
          ),
        );

        return filteredMeals;
      },
      cacheLoader: () async {
        final cached = _categoryMealsBox.get(cacheKey);
        return cached?.toCategoryMealsList().meals;
      },
    );

    if (result.isSuccess || result.isOffline) {
      return result.data!;
    }
    throw Exception(result.error);
  }

  /// Only difference between this and [fetchMealDetailWithoutException] is that
  /// this method throws an exception if the meal contains haram ingredients
  /// or if there's an error fetching the meal details, while the latter
  /// returns null in those cases.
  ///
  /// Unlike [fetchMealDetailWithoutException], this method:
  /// - Throws an exception if the meal contains haram ingredients (when filter is enabled)
  /// - Throws an exception if there's an error fetching the meal
  /// - Throws an exception if the API response is invalid
  ///
  /// Use this method when you want to handle non-halal meals as errors.
  /// Use [fetchMealDetailWithoutException] when you want to silently skip non-halal meals.
  @override
  Future<Meal> fetchMealById(BuildContext context, String id) async {
    final result = await fetchMealDBWithCache<Meal>(
      context: context,
      loadingText: "Fetching recipe details...",
      loader: () async {
        final result = await _fetcher.fetchJSONData(
          "https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id",
        );

        if (result.isError) {
          throw Exception(result.error);
        }

        final meal = MealSpecs.fromJson(result.data!).meals.first;

        // Only check halal status if filter is enabled
        final settings = _ref?.read(settingsProvider);
        if (settings?.halalFilterEnabled ?? true) {
          final containsHaram = await _verifier.containsHaramIngredients(
            meal.ingredients.where((i) => i != null).map((i) => i!).toList(),
          );

          if (containsHaram) {
            throw Exception("This recipe contains non-halal ingredients");
          }
        }

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

    if (result.isSuccess || result.isOffline) {
      return result.data!;
    }
    throw Exception(result.error);
  }
}
