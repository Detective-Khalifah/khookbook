import 'package:flutter/material.dart';
import 'package:khookbook/pages/category_page.dart';
import 'package:khookbook/pages/meal_page.dart';
import 'package:khookbook/pages/specific_category_page.dart';
import 'package:khookbook/pages/welcome_page.dart';
import 'package:khookbook/utilities/specific_category_args.dart';
import 'package:khookbook/utilities/specific_meal_args.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 4,
          centerTitle: true,
        ),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      initialRoute: WelcomePage.id,
      routes: {
        /*MealPage.id: (context) => MealPage(mealId: '52874'),*/
        // TODO: Remove after 'tasting...'
        CategoryPage.id: (context) => CategoryPage(title: 'Recipe Categories'),
        WelcomePage.id: (context) => WelcomePage(title: 'Khookbook'),
      },
      onGenerateRoute: (setting) {
        switch (setting.name) {
          case SpecificCategoryPage.id:
            final args = setting.arguments as SpecificCategoryArguments;

            return MaterialPageRoute(builder: (context) {
              return SpecificCategoryPage(category: args.category);
            });
          case MealPage.id:
            final args = setting.arguments as SpecificMealArguments;

            return MaterialPageRoute(builder: (context) {
              return MealPage(mealId: args.mealId);
            });
          default:
        }
      },
    );
  }
}
