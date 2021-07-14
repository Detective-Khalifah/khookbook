import 'package:flutter/material.dart';
import 'package:khookbook/components/empty_pot.dart';
import 'package:khookbook/services/net_fetcher.dart';
import 'package:khookbook/utilities/meal_model.dart';

class MealPage extends StatefulWidget {
  final String mealId;
  static const String id = 'specific_meal';

  const MealPage({Key? key, required this.mealId}) : super(key: key);

  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  late Future<List<Meal>> meals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mealId),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Meal>>(
          builder: (context, mealSnapshot) {
            if (mealSnapshot.hasData) {
              return Container(
                color: Colors.orangeAccent.shade100,
                child: Column(
                  children: [
                    // Text(mealSnapshot.data[])
                  ],
                ),
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
    meals = _fetchMeal();
  }

  Future<List<Meal>> _fetchMeal() async {
    // Make a network request to 'GET' {@link MealSpecs} data and store the
    // returned {@link JSON} {@link String} in #specificMeal
    NetworkFetcher fetcher = NetworkFetcher(
        link:
            'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.mealId}');
    var specificMeal = await fetcher.fetchJSONData();

    // parse list of categories into {@link @MealSpecs}
    final parsedData = MealSpecs.fromJson(specificMeal);

    // return list of (@link Meal} objects
    print(parsedData.mealSpecs);
    return parsedData.mealSpecs;
  }
}
