import "package:hive_ce/hive.dart";
import "package:khookbook/models/app_preferences_model.dart";
import "package:flutter/material.dart" show ThemeMode;
import "package:khookbook/models/cache/mealdb_category_cache_model.dart";
import "package:khookbook/models/cache/mealdb_category_meals_cache_model.dart";
import "package:khookbook/models/cache/mealdb_meal_cache_model.dart";

@GenerateAdapters([
  AdapterSpec<MealDBCategoryCache>(),
  AdapterSpec<MealDBCategoryData>(),
  AdapterSpec<MealDBCategoryMealsCache>(),
  AdapterSpec<MealDBCategoryMealData>(),
  AdapterSpec<MealDBMealCache>(),
  AdapterSpec<AppPreferences>(),
  AdapterSpec<ThemeMode>(),
])
part "hive_adapters.g.dart";
