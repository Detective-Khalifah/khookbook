import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/providers/mealdb_recipes_providers.dart";
import "package:khookbook/providers/auth_provider.dart";
import "package:khookbook/providers/halal_verification_provider.dart";
import "package:khookbook/models/meal_model.dart";
import "package:khookbook/widgets/floating_video_player.dart";
import "package:khookbook/widgets/halal_status.dart";
import "package:khookbook/widgets/ingredient_card.dart";
import "package:khookbook/widgets/status_banner.dart";
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
  OverlayEntry? _videoOverlay;

  void _showVideoDialog(String videoId) {
    _videoOverlay?.remove();
    _videoOverlay = OverlayEntry(
      builder: (context) => FloatingVideoPlayer(
        videoId: videoId,
        onClose: () {
          _videoOverlay?.remove();
          _videoOverlay = null;
        },
      ),
    );
    Navigator.of(context).overlay?.insert(_videoOverlay!);
  }

  @override
  void dispose() {
    _videoOverlay?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncMeal = ref.watch(
      mealDetailProvider((context: context, id: widget.mealId)),
    );

    return PopScope(
      canPop: _videoOverlay == null,
      onPopInvoked: (didPop) async {
        if (!didPop && _videoOverlay != null) {
          _videoOverlay?.remove();
          _videoOverlay = null;
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text("Recipe Details")),
          body: Column(
            children: [
              if (asyncMeal.isRefreshing)
                const StatusBanner(
                  message: "Loading from cache. Refreshing in background...",
                  type: BannerType.info,
                ),
              if (asyncMeal.hasError)
                StatusBanner(
                  message: "You're offline. Showing cached recipe.",
                  type: BannerType.warning,
                  actionLabel: "Retry",
                  onAction: () => ref.refresh(
                    mealDetailProvider((context: context, id: widget.mealId)),
                  ),
                ),
              Expanded(
                child: RefreshIndicator.adaptive(
                  onRefresh: () => ref.refresh(
                    mealDetailProvider((
                      context: context,
                      id: widget.mealId,
                    )).future,
                  ),
                  child: asyncMeal.when(
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
                            // Text(
                            //   meal.name,
                            //   style: Theme.of(
                            //     context,
                            //   ).textTheme.headlineSmall?.copyWith(color: Colors.black),
                            // ),
                            // const SizedBox(height: 8),
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

                            if (meal.youtubeUrl != null &&
                                initialVideoId != null)
                              ElevatedButton.icon(
                                icon: const Icon(Icons.play_arrow),
                                label: const Text("Watch Video"),
                                onPressed: () =>
                                    _showVideoDialog(initialVideoId),
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
                                onPressed: () =>
                                    launchUrl(Uri.parse(meal.source!)),
                              ),
                            const SizedBox(height: 12),
                            Text(
                              "Ingredients",
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(color: Colors.black),
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
                              "Halal Status",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 8),
                            HalalStatus(
                              ingredients: meal.ingredients
                                  .where((i) => i != null)
                                  .map((i) => i!)
                                  .toList(),
                              onReportPress: () =>
                                  _showReportDialog(context, meal),
                            ),
                            const SizedBox(height: 12),
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
                              // Split instructions into bullet points
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _formatInstructions(
                                  meal.instructions,
                                  context,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (e, st) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Error: $e"),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => ref.refresh(
                              mealDetailProvider((
                                context: context,
                                id: widget.mealId,
                              )),
                            ),
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
        ),
      ),
    );
  }

  List<Widget> _formatInstructions(String instructions, BuildContext context) {
    final steps = instructions
        // Split on numbered steps or newlines
        .split(RegExp(r'(?:\d+\.\s*|\r?\n\s*\r?\n)'))
        .where((step) => step.trim().isNotEmpty)
        .map((step) => step.trim())
        .toList();

    return steps
        .map(
          (step) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: Text(
                    step,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  void _showReportDialog(BuildContext context, Meal meal) {
    final noteController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report Halal Status"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Help us improve our halal verification system by reporting any incorrect status.",
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: "Additional Notes",
                  hintText: "e.g., This ingredient is actually halal certified",
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please provide details about the incorrect status";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // Submit report to Firestore
                final auth = ref.read(authProvider);
                if (auth != null) {
                  ref
                      .read(halalVerificationProvider)
                      .submitReport(
                        recipeId: meal.id,
                        reporterId: auth.uid,
                        notes: noteController.text,
                      );
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Report submitted. Thank you!")),
                );
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
