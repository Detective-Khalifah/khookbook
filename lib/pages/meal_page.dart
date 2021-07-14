import 'package:flutter/material.dart';
import 'package:khookbook/components/category_card.dart';
import 'package:khookbook/components/empty_pot.dart';
import 'package:khookbook/components/rounded_button.dart';
import 'package:khookbook/services/net_fetcher.dart';
import 'package:khookbook/utilities/meal_model.dart';

const String kImageBaseUrl = 'https://www.themealdb.com/images/ingredients/';

class MealPage extends StatefulWidget {
  final String mealId;
  static const String id = 'specific_meal';

  const MealPage({Key? key, required this.mealId}) : super(key: key);

  @override
  _MealPageState createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  late Future<List<Meal>> meal;
  late Meal theMeal =
      Meal(id: '', instructions: '', meal: '', mealThumbnail: '');
  late List<String> theIngredientPortions = [];
  late List<String> theIngredientThumbnail = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasting...'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Meal>>(
          builder: (context, mealSnapshot) {
            if (mealSnapshot.data != null) {
              theMeal = mealSnapshot.data![0];
              theIngredientPortions = parseIngredients(theMeal);
              return Container(
                color: Colors.orangeAccent.shade100,
                padding: EdgeInsets.symmetric(horizontal: 16),
                // height: double.parse(MediaQuery.of(context).size!/1),
                // width: ,
                child: ListView(
                  children: [
                    Container(
                      child: FadeInImage.assetNetwork(
                        // fit: BoxFit.contain,
                        placeholder: '/images/fry_pan.gif',
                        // Before image load
                        image: '${mealSnapshot.data![0].mealThumbnail}/preview',
                        height: 150,
                        width: 150,
                        // After image load
                      ),
                    ),
                    RoundedButton(
                      colour: Colors.orange,
                      label: mealSnapshot.data![0].ytLink.toString(),
                      onPressed: () {
                        // TODO: open YT app or browser
                      },
                    ),
                    Text(
                      '${mealSnapshot.data![0].meal.toString()}\n${mealSnapshot.data![0].cuisineLocale}',
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: CategoryCard(
                              category: theIngredientPortions[index],
                              thumbnail:
                                  '$kImageBaseUrl${theIngredientThumbnail[index]}.png',
                            ),
                          );
                        },
                        itemCount: theIngredientPortions.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Text(mealSnapshot.data![0].instructions.toString()),
                    // Text(mealSnapshot.data[])
                  ],
                ),
              );
            } else
              return EmptyPot();
          },
          future: meal,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    meal = _fetchMeal();
  }

  Future<List<Meal>> _fetchMeal() async {
    // Make a network request to 'GET' {@link MealSpecs} data and store the
    // returned {@link JSON} {@link String} in #specificMeal
    NetworkFetcher fetcher = NetworkFetcher(
        link:
            'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.mealId.isEmpty ? 52874 : widget.mealId}');
    var specificMeal = await fetcher.fetchJSONData();

    // parse list of categories into {@link @MealSpecs}
    final parsedData = MealSpecs.fromJson(specificMeal);

    // return list of (@link Meal} objects
    return parsedData.mealSpecs;
  }

  List<String> parseIngredients(Meal theMeal) {
    List<String?> _ingredients = [
      theMeal.ingredient1,
      theMeal.ingredient2,
      theMeal.ingredient3,
      theMeal.ingredient4,
      theMeal.ingredient5,
      theMeal.ingredient6,
      theMeal.ingredient7,
      theMeal.ingredient8,
      theMeal.ingredient9,
      theMeal.ingredient10,
      theMeal.ingredient11,
      theMeal.ingredient12,
      theMeal.ingredient13,
      theMeal.ingredient14,
      theMeal.ingredient15,
      theMeal.ingredient16,
      theMeal.ingredient17,
      theMeal.ingredient18,
      theMeal.ingredient19,
      theMeal.ingredient20,
    ];
    List<String?> _measures = [
      theMeal.measure1,
      theMeal.measure2,
      theMeal.measure3,
      theMeal.measure4,
      theMeal.measure5,
      theMeal.measure6,
      theMeal.measure7,
      theMeal.measure8,
      theMeal.measure9,
      theMeal.measure10,
      theMeal.measure11,
      theMeal.measure12,
      theMeal.measure13,
      theMeal.measure14,
      theMeal.measure15,
      theMeal.measure16,
      theMeal.measure17,
      theMeal.measure18,
      theMeal.measure19,
      theMeal.measure20,
    ];
    List<String>? _ingredientList = [];
    bool _isAnIngredient = true;
    for (int i = 0; _isAnIngredient; i++) {
      if (_ingredients[i]!.length < 1)
        _isAnIngredient = false;
      else {
        theIngredientThumbnail
            .add('${_ingredients[i]!.trim().replaceAll((r' '), '%20')}');
        // print('Thumbnail Link(s): ' + theIngredientThumbnail[i]);
        _ingredientList.add('${_ingredients[i]}' + ' (${_measures[i]})');
      }
    }
    return _ingredientList;
  }
// String parseIngredients(Meal meal) {
//   String ingredient = '', measure = '';
//   String ingredients = '';
//   for (int i = 0; i < 20; i++) {
//     ingredient = '${join('meal.ingredient', '${i + 1}', meal)}';
//     measure = '${join('meal.measure', '${i + 1}', meal)}';
//     ingredients += ingredient + '($measure)';
//   }
//   return ingredients;
// }
//
// String join(String prefix, String suffix, Meal theMeal) {
//   String link = '$prefix' + '$suffix';
//   theMeal = ('meal.$link') as Meal;
//   print('Link:: $link');
//   // print('link as Meal:: ${link as Meal}');
//   return link;
// }
}
