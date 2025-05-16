import 'package:khookbook/services/net_fetcher.dart';
import 'package:khookbook/models/category_list_model.dart';
import 'package:khookbook/models/meals_list_model.dart';
import 'package:khookbook/models/meal_model.dart';

abstract class RecipesRepository {
  Future<List<Category>> fetchAllCategories();
  Future<List<CategoryMeals>> fetchMealsByCategory(String category);
  Future<Meal> fetchMealById(String id);
}

class NetworkRecipesRepository implements RecipesRepository {
  final _fetcher = NetworkFetcher();

  @override
  Future<List<Category>> fetchAllCategories() async {
    final json = await _fetcher.fetchJSONData(
        'https://www.themealdb.com/api/json/v1/1/categories.php');
    return CategoriesList.fromJson(json).categories;
  }

  @override
  Future<List<CategoryMeals>> fetchMealsByCategory(String category) async {
    final json = await _fetcher.fetchJSONData(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');
    return CategoryMealsList.fromJson(json).meals;
  }

  @override
  Future<Meal> fetchMealById(String id) async {
    final json = await _fetcher.fetchJSONData(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id');
    return MealSpecs.fromJson(json).meals.first;
  }
}
