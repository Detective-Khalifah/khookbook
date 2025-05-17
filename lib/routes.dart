// routes.dart
import 'package:flutter/material.dart';
import 'package:khookbook/pages/category_page.dart';
import 'package:khookbook/pages/home_page.dart';
import 'package:khookbook/pages/meal_page.dart';
import 'package:khookbook/pages/specific_category_page.dart';
import 'package:khookbook/pages/welcome_page.dart';
import 'package:khookbook/utilities/specific_category_args.dart';
import 'package:khookbook/utilities/specific_meal_args.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomePage.id:
        return MaterialPageRoute(
            builder: (_) => WelcomePage(title: 'Khookbook'));
      case CategoryPage.id:
        return MaterialPageRoute(
            builder: (_) => CategoryPage(title: 'Recipe Categories'));
      case SpecificCategoryPage.id:
        final args = settings.arguments as SpecificCategoryArguments;
        return MaterialPageRoute(
            builder: (_) => SpecificCategoryPage(category: args.category));
      case MealPage.id:
        final args = settings.arguments as SpecificMealArguments;
        return MaterialPageRoute(builder: (_) => MealPage(mealId: args.mealId));
      case HomePage.id:
        return MaterialPageRoute(builder: (ctx) => HomePage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Invalid route')),
      );
    });
  }
}
