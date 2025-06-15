import "package:flutter/material.dart";
import "package:khookbook/pages/category_page.dart";
import "package:khookbook/pages/home_page.dart";
import "package:khookbook/pages/meal_page.dart";
import "package:khookbook/pages/sign_in_page.dart" show SignInPage;
import "package:khookbook/pages/sign_up_page.dart" show SignUpPage;
import "package:khookbook/pages/specific_category_page.dart";
import "package:khookbook/pages/welcome_page.dart";
import "package:khookbook/utilities/specific_category_args.dart";
import "package:khookbook/utilities/specific_meal_args.dart";

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomePage.id:
        return MaterialPageRoute(
          builder: (_) => WelcomePage(title: "Welcome to Khookbook!"),
        );
      case CategoryPage.id:
        return MaterialPageRoute(builder: (_) => CategoryPage());
      case SpecificCategoryPage.id:
        final args = settings.arguments as SpecificCategoryArguments;
        return MaterialPageRoute(
          builder: (_) => SpecificCategoryPage(category: args.category),
        );
      case MealPage.id:
        final args = settings.arguments as SpecificMealArguments;
        return MaterialPageRoute(builder: (_) => MealPage(mealId: args.mealId));
      case HomePage.id:
        return MaterialPageRoute(builder: (_) => HomePage());
      // TODO: Use different appbar title depending on screen size
      case SignInPage.id:
        return MaterialPageRoute(
          builder: (_) => SignInPage(title: "Sign In to your account"),
        );
      case SignUpPage.id:
        return MaterialPageRoute(
          builder: (_) => SignUpPage(title: "Sign Up for an account"),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text("Error")),
          body: Center(child: Text("Invalid route")),
        );
      },
    );
  }
}
