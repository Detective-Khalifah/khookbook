import 'package:flutter/material.dart';
import 'package:khookbook/components/category_card.dart';
import 'package:khookbook/components/empty_pot.dart';
import 'package:khookbook/pages/meal_page.dart';
import 'package:khookbook/services/net_fetcher.dart';
import 'package:khookbook/utilities/meals_list_model.dart';
import 'package:khookbook/utilities/specific_meal_args.dart';

class SpecificCategoryPage extends StatefulWidget {
  late final String? category;
  static const String id = 'category';

  SpecificCategoryPage({Key? key, this.category}) : super(key: key);

  @override
  _SpecificCategoryPageState createState() => _SpecificCategoryPageState();
}

class _SpecificCategoryPageState extends State<SpecificCategoryPage> {
  late Future<List<Meal>> meals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category}'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Meal>>(
          builder: (context, mealsSnapshot) {
            if (mealsSnapshot.hasData) {
              return Container(
                color: Colors.orangeAccent.shade100,
                child: GridView.builder(
                    itemCount: mealsSnapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        category: mealsSnapshot.data![index].meal,
                        thumbnail: mealsSnapshot.data![index].mealThumbnail,
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            MealPage.id,
                            arguments: SpecificMealArguments(
                              mealsSnapshot.data![index].id.toString(),
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
              return EmptyPot();
          },
          future: meals,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    meals = _fetchMeals();
  }

  Future<List<Meal>> _fetchMeals() async {
    // Make a network request to 'GET' {@link MealsList} data and store the
    // returned {@link JSON} {@link String} in #specificCategory
    NetworkFetcher fetcher = NetworkFetcher(
        link:
            'https://www.themealdb.com/api/json/v1/1/filter.php?c=${widget.category}');
    var specificCategory = await fetcher.fetchJSONData();

    // parse list of categories into {@link @MealsList}
    final parsedData = MealsList.fromJson(specificCategory);

    // return list of (@link Meal} objects
    return parsedData.meals;
  }
}
