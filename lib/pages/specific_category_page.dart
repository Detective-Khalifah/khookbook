import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khookbook/components/category_card.dart';
import 'package:khookbook/pages/meal_page.dart';
import 'package:khookbook/providers/recipes_providers.dart';
import 'package:khookbook/services/net_fetcher.dart';
import 'package:khookbook/models/meals_list_model.dart';
import 'package:khookbook/utilities/specific_meal_args.dart';

class SpecificCategoryPage extends ConsumerWidget {
  final String category;
  static const String id = 'category';

  const SpecificCategoryPage({super.key, required this.category});
  // late Future<List<Meal>> meals;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategoryMeals = ref.watch(categoryMealsProvider(category));

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: asyncCategoryMeals.when(
        data: (meals) => GridView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // crossAxisSpacing: 8,
            // mainAxisSpacing: 8,
            // childAspectRatio: (itemWidth / itemHeight),
          ),
          itemCount: meals.length,
          itemBuilder: (_, i) {
            final meal = meals[i];
            return CategoryCard(
              category: meal.name,
              thumbnail: meal.thumbnailUrl,
              onPress: () => Navigator.pushNamed(
                context,
                MealPage.id,
                arguments: SpecificMealArguments(meal.id),
              ),
              onSave: () {
                // TODO: call a provider to save to Firestore
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<List<CategoryMeals>> _fetchMeals() async {
    // Make a network request to 'GET' {@link MealsList} data and store the
    // returned {@link JSON} {@link String} in #specificCategory
    NetworkFetcher fetcher = NetworkFetcher();
    var specificCategory = await fetcher.fetchJSONData(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category');

    // parse list of categories into {@link @MealsList}
    final parsedData = CategoryMealsList.fromJson(specificCategory);

    // return list of (@link Meal} objects
    return parsedData.meals;
  }
}
