import 'package:flutter/material.dart';
import 'package:khookbook/components/category_card.dart';
import 'package:khookbook/services/net_fetcher.dart';
import 'package:khookbook/utilities/meal_model.dart';

class SpecificCategoryPage extends StatefulWidget {
  late final String? category;
  static const String id = 'category';

  SpecificCategoryPage({Key? key, this.category}) : super(key: key);

  @override
  _SpecificCategoryPageState createState() => _SpecificCategoryPageState();
}

class _SpecificCategoryPageState extends State<SpecificCategoryPage> {
  late Future<List<Meal>> meals;
  late List<Widget> mealCards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Meal>>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: Colors.orangeAccent.shade100,
                child: GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        id: snapshot.data![index].id,
                        category: snapshot.data![index].meal,
                        thumbnail: snapshot.data![index].mealThumbnail,
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
