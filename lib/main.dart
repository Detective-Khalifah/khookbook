import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart" show kIsWeb;
import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:khookbook/firebase_options.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/hive_registrar.g.dart";
import "package:khookbook/models/cache/mealdb_category_cache_model.dart";
import "package:khookbook/models/cache/mealdb_category_meals_cache_model.dart";
import "package:khookbook/models/cache/mealdb_meal_cache_model.dart";
import "package:khookbook/pages/welcome_page.dart";
import "package:khookbook/providers/theme_provider.dart" show themeProvider;
import "package:khookbook/routes.dart";
import "package:khookbook/theme.dart";
import "package:path_provider/path_provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive and register adapters
  await initHive();

  runApp(ProviderScope(child: MyApp()));
}

Future<void> initHive() async {
  String path = "/assets";

  if (!kIsWeb) {
    final appDocDir = await getApplicationDocumentsDirectory();
    path = appDocDir.path;
  }

  Hive.init("$path/hive_db");

  Hive.registerAdapter(MealDBCategoryCacheAdapter());
  Hive.registerAdapter(MealDBCategoryDataAdapter());
  if (!Hive.isBoxOpen('mealdb_categories')) {
    await Hive.openBox<MealDBCategoryCache>('mealdb_categories');
  }

  Hive.registerAdapter(MealDBCategoryMealDataAdapter());
  Hive.registerAdapter(MealDBCategoryMealsCacheAdapter());
  if (!Hive.isBoxOpen('mealdb_specific_categories')) {
    await Hive.openBox<MealDBCategoryMealsCache>('mealdb_specific_categories');
  }

  Hive.registerAdapter(MealDBMealCacheAdapter());
  if (!Hive.isBoxOpen('mealdb_meals')) {
    await Hive.openBox<MealDBMealCache>('mealdb_meals');
  }

  // Hive.registerAdapter(MealDBFavouriteCacheAdapter());
  // if (!Hive.isBoxOpen('mealdb_favourites')) {
  //   await Hive.openBox<MealDBMealCache>('mealdb_favourites');
  // }
  if (!Hive.isBoxOpen('app_preferences')) {
    await Hive.openBox<String>('app_preferences');
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.watch(themeProvider);

    return MaterialApp(
      title: "Khookbooky",
      theme: MaterialTheme(ThemeData.light().textTheme).light(),
      darkTheme: MaterialTheme(ThemeData.dark().textTheme).dark(),
      themeMode: themeNotifier,
      initialRoute: WelcomePage.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
