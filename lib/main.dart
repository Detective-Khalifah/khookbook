import "package:firebase_core/firebase_core.dart";
import "package:flutter/foundation.dart" show kIsWeb;
import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_flutter.dart";
import "package:khookbook/firebase_options.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/hive/hive_registrar.g.dart";
// import "package:khookbook/hive/hive_adapters.dart";
import "package:khookbook/models/app_preferences_model.dart"
    show AppPreferences;
import "package:khookbook/models/cache/mealdb_category_cache_model.dart";
import "package:khookbook/models/cache/mealdb_category_meals_cache_model.dart"
    show MealDBCategoryMealsCache;
import "package:khookbook/models/cache/mealdb_meal_cache_model.dart"
    show MealDBMealCache;
// import "package:khookbook/models/app_preference_model.dart";
// import "package:khookbook/models/cache/mealdb_category_cache_model.dart";
// import "package:khookbook/models/cache/mealdb_category_meals_cache_model.dart";
// import "package:khookbook/models/cache/mealdb_meal_cache_model.dart";
import "package:khookbook/pages/welcome_page.dart";
import "package:khookbook/providers/theme_provider.dart" show themeProvider;
import "package:khookbook/routes.dart";
import "package:khookbook/theme.dart";
import "package:path_provider/path_provider.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initHive();

  // Register cleanup on app termination
  WidgetsBinding.instance.addObserver(
    _AppLifecycleObserver(onTerminate: closeHive),
  );

  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initHive() async {
  String path = "/assets";

  if (!kIsWeb) {
    final appDocDir = await getApplicationDocumentsDirectory();
    path = appDocDir.path;
  }

  Hive
    ..init("$path/hive_db")
    ..registerAdapters();

  // Open boxes only if not already open
  try {
    if (!Hive.isBoxOpen("mealdb_categories")) {
      await Hive.openBox<MealDBCategoryCache>("mealdb_categories");
    }
    if (!Hive.isBoxOpen("mealdb_specific_categories")) {
      await Hive.openBox<MealDBCategoryMealsCache>(
        "mealdb_specific_categories",
      );
    }
    if (!Hive.isBoxOpen("mealdb_meals")) {
      await Hive.openBox<MealDBMealCache>("mealdb_meals");
    }
    // Hive.registerAdapter(MealDBFavouriteCacheAdapter());
    // if (!Hive.isBoxOpen("mealdb_favourites")) {
    //   await Hive.openBox<MealDBMealCache>("mealdb_favourites");
    // }
    if (!Hive.isBoxOpen("app_preference")) {
      await Hive.openBox<AppPreferences>("app_preference");
    }
  } catch (e) {
    debugPrint("Hive box opening error: $e");
  }
}

Future<void> closeHive() async {
  await Future.wait([
    if (Hive.isBoxOpen("mealdb_categories"))
      Hive.box<MealDBCategoryCache>("mealdb_categories").close(),
    if (Hive.isBoxOpen("mealdb_specific_categories"))
      Hive.box<MealDBCategoryMealsCache>("mealdb_specific_categories").close(),
    if (Hive.isBoxOpen("mealdb_meals"))
      Hive.box<MealDBMealCache>("mealdb_meals").close(),
    if (Hive.isBoxOpen("app_preferences"))
      Hive.box<AppPreferences>("app_preferences").close(),
  ]);
}

class _AppLifecycleObserver extends WidgetsBindingObserver {
  final Future<void> Function() onTerminate;

  _AppLifecycleObserver({required this.onTerminate});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      onTerminate();
    }
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
      onGenerateRoute: (settings) {
        return RouteGenerator.generateRoute(settings, ref);
      },
    );
  }
}
