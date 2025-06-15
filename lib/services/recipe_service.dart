// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';

import 'package:khookbook/services/mealdb_service.dart';

import '../models/user_recipe_model.dart';
import 'halal_verification.dart';
import 'net_fetcher.dart';

class RecipeService {
  final NetworkFetcher _fetcher;
  final HalalVerificationService _verifier;
  final Box<UserRecipe> _recipeBox;

  RecipeService(this._fetcher, this._verifier, this._recipeBox);

  Future<UserRecipe> getRecipe(String id) async {
    // Check cache first
    if (_recipeBox.containsKey(id)) {
      return _recipeBox.get(id)!;
    }

    // Fetch from network
    final json = await MealDBService(_fetcher).getRecipeById(id);
    final recipe = UserRecipe.fromFirestore(json?['meals'][0]);

    // Auto-check ingredients
    if (await _verifier.containsHaramIngredients(recipe.ingredients)) {
      recipe.verificationStatus = 'haram';
    }

    // Cache result
    await _recipeBox.put(id, recipe);

    return recipe;
  }
}
