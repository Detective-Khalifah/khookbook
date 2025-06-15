import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:khookbook/widgets/category_card.dart";
import "package:khookbook/pages/meal_page.dart";
import "package:khookbook/providers/recipes_providers.dart";
import "package:khookbook/utilities/specific_meal_args.dart";
import "package:khookbook/utilities/network/network_loader.dart";

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
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await executeNetworkOperation(
            context: context,
            loader: () => ref.refresh(
              categoryMealsProvider((
                context: context,
                category: category,
              )).future,
            ),
            onError: (error) => debugPrint("Error refreshing meals: $error"),
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
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
              loading: () => const Center(child: CircularProgressIndicator()),
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
      ),
    );
  }
}
