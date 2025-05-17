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

  final bool isUserRecipe = false;

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
            height: MediaQuery.of(context).size.height,
            color: Colors.orangeAccent.shade100,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                CachedNetworkImage(
                  imageUrl: "${meal.thumbnailUrl}/preview",
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
                      builder: (_) => YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _ytController!,
                        ),
                        builder: (context, player) =>
                            Column(children: [player]),
                      ),
                      // YoutubePlayer(controller: _ytController!),
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
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: meal.ingredientPairs.length,
                    itemBuilder: (context, index) {
                      // final ingredientList = meal.ingredientPairs;
                      return meal.ingredientPairs.map((pair) {
                        return IngredientCard(
                          ingredient: pair,
                          thumbnail:
                              "$kImageBaseUrl${meal.ingredients[index]?.trim().replaceAll((r' '), '%20')}.png",
                        );
                      }).toList()[index];
                      // final ingredient = meal.ingredients[index];
                      // final measure = meal.measures[index];
                      // if (ingredient != null &&
                      //     measure != null &&
                      //     ingredient.isNotEmpty) {
                      //   return IngredientCard(
                      //       ingredient: ingredient,
                      //       measure: measure,
                      //       thumbnail:
                      //           "$kImageBaseUrl${ingredient.trim().replaceAll((r' '), '%20')}.png");
                      // } else {
                      //   return SizedBox.shrink();
                      // }
                    },
                  ),
                ),

                const Divider(height: 24),
                const SizedBox(height: 16),
                Text(
                  'Instructions',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                if (isUserRecipe)
                  // Markdown instructions for user recipes:
                  MarkdownWidget(
                    data: meal.instructions,
                    // styleConfig: StyleConfig(
                    //   pConfig: PConfig(
                    //     textStyle: Theme.of(context).textTheme.bodyText2,
                    //   ),
                    //   listConfig: const ListConfig(),
                    // ),
                  )
                else
                  // plain text for API recipes:
                  Text(
                    meal.instructions,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1.5),
                    textAlign: TextAlign.left,
                  ),
              ],
            ),
          );
        },
        loading: () => EmptyPot(),
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
}
