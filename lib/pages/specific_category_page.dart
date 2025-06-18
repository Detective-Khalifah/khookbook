import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:khookbook/widgets/category_card.dart";
import "package:khookbook/pages/meal_page.dart";
import "package:khookbook/providers/mealdb_recipes_providers.dart";
import "package:khookbook/utilities/specific_meal_args.dart";
import "package:khookbook/utilities/network/network_loader.dart";
import "package:khookbook/widgets/status_banner.dart";

class SpecificCategoryPage extends ConsumerWidget {
  final String category;
  static const String id = "category";

  const SpecificCategoryPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategoryMeals = ref.watch(
      categoryMealsProvider((context: context, category: category)),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Category - $category")),
      body: Column(
        children: [
          if (asyncCategoryMeals.isRefreshing)
            const StatusBanner(
              message: "Loading from cache. Refreshing in background...",
              type: BannerType.info,
            ),
          if (asyncCategoryMeals.hasError)
            StatusBanner(
              message: "You're offline. Showing cached recipes.",
              type: BannerType.warning,
              actionLabel: "Retry",
              onAction: () => ref.refresh(
                categoryMealsProvider((context: context, category: category)),
              ),
            ),
          Expanded(
            child: RefreshIndicator.adaptive(
              onRefresh: () => ref.refresh(
                categoryMealsProvider((
                  context: context,
                  category: category,
                )).future,
              ),
              child: asyncCategoryMeals.when(
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
                loading: () => SizedBox.shrink(),
                error: (e, st) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Error: $e"),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.refresh(
                          categoryMealsProvider((
                            context: context,
                            category: category,
                          )),
                        ),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
