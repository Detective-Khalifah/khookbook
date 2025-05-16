import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khookbook/components/empty_pot.dart';
import 'package:khookbook/components/rounded_button.dart';
import 'package:khookbook/providers/recipes_providers.dart';
import 'package:khookbook/models/meal_model.dart';
import 'package:khookbook/widgets/ingredient_card.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

const String kImageBaseUrl = 'https://www.themealdb.com/images/ingredients/';

class MealPage extends ConsumerStatefulWidget {
  final String mealId;
  static const String id = 'specific_meal';

  const MealPage({super.key, required this.mealId});

  @override
  ConsumerState<MealPage> createState() => _MealPageState();
}

class _MealPageState extends ConsumerState<MealPage> {
  YoutubePlayerController? _ytController;
  late Future<List<Meal>> meal;
  late Meal theMeal = Meal(
      id: '',
      instructions: '',
      // meal: '',
      // mealThumbnail: '',
      name: '',
      thumbnailUrl: '',
      ingredients: [],
      measures: []);
  late List<String> theIngredientPortions = [];
  late List<String> theIngredientThumbnail = [];

  @override
  Widget build(BuildContext context) {
    final asyncMeal = ref.watch(mealDetailProvider(widget.mealId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe'),
      ),
      body: asyncMeal.when(
        data: (meal) {
          // initialize YouTube controller if there's a link
          if (_ytController == null && meal.youtubeUrl != null) {
            _ytController = YoutubePlayerController(
              initialVideoId: meal.youtubeUrl!,
              flags: const YoutubePlayerFlags(autoPlay: false),
            );
          }
          return Container(
            height: MediaQuery.of(context).size.height / 1,
            color: Colors.orangeAccent.shade100,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CachedNetworkImage(
                  imageUrl: meal.thumbnailUrl,
                  height: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return FadeInImage.assetNetwork(
                      placeholder: 'assets/images/fry_pan.gif',
                      image: "${meal.thumbnailUrl}/preview",
                      height: 150,
                      width: 150,
                      fit: BoxFit.contain,
                    );
                  },
                ),
                const SizedBox(height: 12),
                if (_ytController != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Watch Video'),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (_) => YoutubePlayer(controller: _ytController!),
                    ),
                  ),
                const SizedBox(height: 12),
                Text(meal.name,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.black)),
                const SizedBox(height: 8),
                // Ingredients list
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: meal.ingredients.length,
                    itemBuilder: (context, index) {
                      final ingredient = meal.ingredients[index];
                      final measure = meal.measures[index];
                      if (ingredient != null &&
                          measure != null &&
                          ingredient.isNotEmpty) {
                        return IngredientCard(
                            ingredient: ingredient,
                            measure: measure,
                            thumbnail:
                                "$kImageBaseUrl${ingredient.trim().replaceAll((r' '), '%20')}.png");
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),

                const Divider(height: 24),
                // Markdown instructions
                // MarkdownWidget(data: meal.instructions),
              ],
            ),
          );
        },
        loading: () => EmptyPot(),
        // const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
      // SafeArea(
      //   child: FutureBuilder<List<Meal>>(
      //     builder: (context, mealSnapshot) {
      //       if (mealSnapshot.data != null) {
      //         theMeal = mealSnapshot.data![0];
      //         theIngredientPortions = parseIngredients(theMeal);
      //         return Container(
      //           color: Colors.orangeAccent.shade100,
      //           padding: EdgeInsets.symmetric(horizontal: 16),
      //           // height: double.parse(MediaQuery.of(context).size!/1),
      //           // width: ,
      //           child: ListView(
      //             children: [
      //               Container(
      //                 child: FadeInImage.assetNetwork(
      //                   // fit: BoxFit.contain,
      //                   placeholder: '/images/fry_pan.gif',
      //                   // Before image load
      //                   image: '${mealSnapshot.data![0].mealThumbnail}/preview',
      //                   height: 150,
      //                   width: 150,
      //                   // After image load
      //                 ),
      //               ),
      //               RoundedButton(
      //                 colour: Colors.orange,
      //                 label: mealSnapshot.data![0].ytLink.toString(),
      //                 onPressed: () {
      //                   // TODO: open YT app or browser
      //                 },
      //               ),
      //               Text(
      //                 '${mealSnapshot.data![0].meal.toString()}\n${mealSnapshot.data![0].cuisineLocale}',
      //               ),
      //               Container(
      //                 height: 200,
      //                 child: ListView.builder(
      //                   itemBuilder: (context, index) {
      //                     return Container(
      //                       margin: EdgeInsets.symmetric(horizontal: 20),
      //                       child: CategoryCard(
      //                         category: theIngredientPortions[index],
      //                         thumbnail:
      //                             '$kImageBaseUrl${theIngredientThumbnail[index]}.png',
      //                       ),
      //                     );
      //                   },
      //                   itemCount: theIngredientPortions.length,
      //                   scrollDirection: Axis.horizontal,
      //                 ),
      //               ),
      //               Text(mealSnapshot.data![0].instructions.toString()),
      //               // Text(mealSnapshot.data[])
      //             ],
      //           ),
      //         );
      //       } else
      //         return EmptyPot();
      //     },
      //     future: meal,
      //   ),
      // ),
    );
  }

//   @override
//   void initState() {
//     super.initState();
//     meal = _fetchMeal();
//   }

//   Future<List<Meal>> _fetchMeal() async {
//     // Make a network request to 'GET' {@link MealSpecs} data and store the
//     // returned {@link JSON} {@link String} in #specificMeal
//     NetworkFetcher fetcher = NetworkFetcher();
//     var specificMeal = await fetcher.fetchJSONData(
//         'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.mealId.isEmpty ? 52874 : widget.mealId}');

//     // parse list of categories into {@link @MealSpecs}
//     final parsedData = MealSpecs.fromJson(specificMeal);

//     // return list of (@link Meal} objects
//     return parsedData.mealSpecs;
//   }

//   List<String> parseIngredients(Meal theMeal) {
//     List<String?> _ingredients = [
//       theMeal.ingredient1,
//       theMeal.ingredient2,
//       theMeal.ingredient3,
//       theMeal.ingredient4,
//       theMeal.ingredient5,
//       theMeal.ingredient6,
//       theMeal.ingredient7,
//       theMeal.ingredient8,
//       theMeal.ingredient9,
//       theMeal.ingredient10,
//       theMeal.ingredient11,
//       theMeal.ingredient12,
//       theMeal.ingredient13,
//       theMeal.ingredient14,
//       theMeal.ingredient15,
//       theMeal.ingredient16,
//       theMeal.ingredient17,
//       theMeal.ingredient18,
//       theMeal.ingredient19,
//       theMeal.ingredient20,
//     ];
//     List<String?> _measures = [
//       theMeal.measure1,
//       theMeal.measure2,
//       theMeal.measure3,
//       theMeal.measure4,
//       theMeal.measure5,
//       theMeal.measure6,
//       theMeal.measure7,
//       theMeal.measure8,
//       theMeal.measure9,
//       theMeal.measure10,
//       theMeal.measure11,
//       theMeal.measure12,
//       theMeal.measure13,
//       theMeal.measure14,
//       theMeal.measure15,
//       theMeal.measure16,
//       theMeal.measure17,
//       theMeal.measure18,
//       theMeal.measure19,
//       theMeal.measure20,
//     ];
//     List<String>? _ingredientList = [];
//     bool _isAnIngredient = true;
//     for (int i = 0; _isAnIngredient; i++) {
//       if (_ingredients[i]!.length < 1)
//         _isAnIngredient = false;
//       else {
//         theIngredientThumbnail
//             .add('${_ingredients[i]!.trim().replaceAll((r' '), '%20')}');
//         _ingredientList.add('${_ingredients[i]}' + ' (${_measures[i]})');
//       }
//     }
//     return _ingredientList;

  // List<String> parseIngredients(Meal meal) {
  //   List<String> ingredients = [];
  //   for (int i = 1; i <= 20; i++) {
  //     final ingredient = meal['ingredient$i'];
  //     final measure = meal['measure$i'];
  //     if (ingredient != null && ingredient.isNotEmpty) {
  //       ingredients.add('$ingredient ($measure)');
  //     }
  //   }
  //   return ingredients;
  // }

  // List<String> parseIngredients(Meal meal) {
  //   List<String> ingredients = [];
  //   for (int i = 1; i <= 20; i++) {
  //     final ingredientKey = 'strIngredient$i';
  //     final measureKey = 'strMeasure$i';
  //     final ingredient = meal[ingredientKey];
  //     final measure = meal[measureKey];

  //     if (ingredient != null && ingredient.isNotEmpty) {
  //       ingredients.add('$ingredient (${measure ?? ''})');
  //     }
  //   }
  //   return ingredients;
  // }
  // }
}
