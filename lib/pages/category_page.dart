import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:khookbook/widgets/category_card.dart";
import "package:khookbook/pages/specific_category_page.dart";
import "package:khookbook/providers/mealdb_recipes_providers.dart";
import "package:khookbook/utilities/specific_category_args.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";

import 'package:khookbook/widgets/status_banner.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  static const String id = "categories";

  // final _auth = FirebaseAuth.instance;

  // void _getUser() {
  //   final fetchedUser = _auth.currentUser;
  //   if (fetchedUser != null) {
  //     signedInUser = fetchedUser;
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _getUser();
  //   categories = _fetchCategories();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategories = ref.watch(categoriesProvider(context));

    return Scaffold(
      appBar: AppBar(title: const Text("Recipe Categories")),
      body: Column(
        children: [
          if (asyncCategories.isRefreshing)
            const StatusBanner(
              message: "Loading from cache. Refreshing in background...",
              type: BannerType.info,
            ),
          if (asyncCategories.hasError)
            StatusBanner(
              message: "You're offline. Showing cached recipes.",
              type: BannerType.warning,
              actionLabel: "Retry",
              onAction: () => ref.refresh(categoriesProvider(context)),
            ),
          Expanded(
            child: RefreshIndicator.adaptive(
              onRefresh: () => ref.refresh(categoriesProvider(context).future),
              child: asyncCategories.when(
                data: (categories) => Container(
                  color: Colors.orangeAccent.shade200,
                  child: GridView.builder(
                    padding: EdgeInsets.all(10.0),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      // crossAxisCount: 2,
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CategoryCard(
                        id: category.id,
                        category: category.category,
                        thumbnail: category.thumbnail,
                        description: category.description,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            SpecificCategoryPage.id,
                            arguments: SpecificCategoryArguments(
                              categories[index].category.toString(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                loading: () => SizedBox.shrink(),
                error: (e, st) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Error: $e"),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            ref.refresh(categoriesProvider(context)),
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
