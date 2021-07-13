import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:khookbook/components/category_card.dart';
import 'package:khookbook/pages/specific_category_page.dart';
import 'package:khookbook/services/net_fetcher.dart';
import 'package:khookbook/utilities/category_list_model.dart';
import 'package:khookbook/utilities/specific_category_args.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key, required this.title}) : super(key: key);

  final String title;
  static const String id = 'categories';

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<Category>> categories;
  List<Widget> categoryCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Category>>(
          builder: (context, categoriesSnapshot) {
            if (categoriesSnapshot.hasData) {
              return Container(
                color: Colors.orangeAccent.shade100,
                child: GridView.builder(
                    itemCount: categoriesSnapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        id: categoriesSnapshot.data![index].id,
                        category: categoriesSnapshot.data![index].category,
                        thumbnail: categoriesSnapshot.data![index].thumbnail,
                        description:
                            categoriesSnapshot.data![index].description,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            SpecificCategoryPage.id,
                            arguments: SpecificCategoryArguments(
                              categoriesSnapshot.data![index].category
                                  .toString(),
                            ),
                          );
                        },
                        onSave: () {
                          // TODO: Save to Firebase account
                        },
                      );
                    }),
              );
            } else
              return Text(
                'Error!',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 36,
                    fontWeight: FontWeight.w900),
              );
          },
          future: categories,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    categories = _fetchCategories();
  }

  Future<List<Category>> _fetchCategories() async {
    // make a network request to 'GET' {@link CategoriesList} data and store the
    // returned {@link JSON} {@link String} in #jsonStringData
    NetworkFetcher fetcher = NetworkFetcher(
        link: 'https://www.themealdb.com/api/json/v1/1/categories.php');
    var jsonStringData = await fetcher.fetchJSONData();

    // parse list of categories into {@link @CategoriesList}
    final parsedData = CategoriesList.fromJson(jsonStringData);

    // return list of (@link Category} objects
    return parsedData.categories;
  }
}
