import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khookbook/components/category_card.dart';
import 'package:khookbook/components/empty_pot.dart';
import 'package:khookbook/pages/specific_category_page.dart';
import 'package:khookbook/providers/recipes_providers.dart';
import 'package:khookbook/services/net_fetcher.dart';
import 'package:khookbook/models/category_list_model.dart';
import 'package:khookbook/utilities/specific_category_args.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key, required this.title});

  final String title;
  static const String id = 'categories';

  // final _auth = FirebaseAuth.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   _getUser();
  //   categories = _fetchCategories();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: asyncCategories.when(
        data: (categories) => Container(
          color: Colors.orangeAccent.shade200,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              // crossAxisCount: 2,
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 4,
            ),
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
                onSave: () {
                  // TODO: Save to Firebase account
                },
              );
            },
            itemCount: categories.length,
            padding: EdgeInsets.all(10.0),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  // void _getUser() {
  //   final fetchedUser = _auth.currentUser;
  //   if (fetchedUser != null) {
  //     signedInUser = fetchedUser;
  //   }
  // }

  Future<List<Category>> _fetchCategories() async {
    // make a network request to 'GET' {@link CategoriesList} data and store the
    // returned {@link JSON} {@link String} in #jsonStringData
    NetworkFetcher fetcher = NetworkFetcher();
    var jsonStringData = await fetcher.fetchJSONData(
        'https://www.themealdb.com/api/json/v1/1/categories.php');

    // parse list of categories into {@link @CategoriesList}
    final parsedData = CategoriesList.fromJson(jsonStringData);

    // return list of (@link Category} objects
    return parsedData.categories;
  }
}
