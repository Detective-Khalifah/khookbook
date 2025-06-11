import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/widgets/empty_pot.dart";
import "package:khookbook/providers/recipes_providers.dart";
import "package:khookbook/models/meal_model.dart";
import "package:khookbook/widgets/ingredient_card.dart";
import "package:khookbook/widgets/youtube_player.dart";
import "package:markdown_widget/markdown_widget.dart";
import "package:url_launcher/url_launcher.dart";
import "package:youtube_player_flutter/youtube_player_flutter.dart";

const String kImageBaseUrl = "https://www.themealdb.com/images/ingredients/";

class MealPage extends ConsumerStatefulWidget {
  final String mealId;
  static const String id = "specific_meal";

  const MealPage({super.key, required this.mealId});

  @override
  ConsumerState<MealPage> createState() => _MealPageState();
}

class _MealPageState extends ConsumerState<MealPage> {
  final bool isUserRecipe = false;

  @override
  Widget build(BuildContext context) {
    final asyncMeal = ref.watch(mealDetailProvider(widget.mealId));

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Recipe"),
      // ),
      body: asyncMeal.when(
        data: (meal) {
          // initialize YouTube controller if there"s a link
          String? initialVideoId = (meal.youtubeUrl != null)
              ? YoutubePlayer.convertUrlToId(meal.youtubeUrl!)
              : "";
          return Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.orangeAccent.shade100,
            padding: EdgeInsets.all(16),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  meal.name,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: meal.thumbnailUrl,
                    // height: 200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return FadeInImage.assetNetwork(
                        placeholder: "assets/images/fry_pan.gif",
                        image: meal.thumbnailUrl,
                        // height: 150,
                        // width: 150,
                        // fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                if (meal.youtubeUrl != null && initialVideoId != null)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Watch Video"),
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (_) => YTPlayer(initialVideoId: initialVideoId),
                    ),
                  ),
                Column(
                  spacing: 8,
                  children: [
                    if (meal.category != null)
                      Row(
                        spacing: 8,
                        children: [
                          Text("Category: "),
                          Chip(label: Text(meal.category!)),
                        ],
                      ),
                    if (meal.area != null)
                      Row(
                        spacing: 16,
                        children: [
                          Text("Cuisine: "),
                          Chip(label: Text(meal.area!)),
                        ],
                      ),
                    if (meal.tags != null)
                      Row(
                        spacing: 32,
                        children: [
                          Text("Tags: "),
                          Wrap(
                            spacing: 4,
                            children: [
                              ...meal.tags!.split(",").map((tag) {
                                return Chip(label: Text(tag));
                              }),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
                if (meal.source != null)
                  OutlinedButton.icon(
                    icon: Icon(Icons.link),
                    label: Text("Source"),
                    onPressed: () => launchUrl(Uri.parse(meal.source!)),
                  ),
                const SizedBox(height: 12),
                Text(
                  "Ingredients",
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                // Ingredients list
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: meal.ingredientPairs.length,
                    itemBuilder: (context, index) {
                      return meal.ingredientPairs.map((pair) {
                        return IngredientCard(
                          ingredient: pair,
                          thumbnail:
                              "$kImageBaseUrl${meal.ingredients[index]?.trim().replaceAll((r" "), "%20")}.png",
                        );
                      }).toList()[index];
                    },
                  ),
                ),

                const Divider(height: 16),
                const SizedBox(height: 8),
                Text(
                  "Instructions",
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
                  // Plain text for API recipes
                  Text(
                    meal.instructions,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.5),
                    textAlign: TextAlign.left,
                  ),
              ],
            ),
          );
        },
        loading: () => EmptyPot(),
        error: (e, st) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
