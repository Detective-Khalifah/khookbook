import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khookbook/firebase_options.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:khookbook/pages/category_page.dart';
import 'package:khookbook/pages/sign_in_page.dart';
import 'package:khookbook/pages/sign_up_page.dart';
import 'package:khookbook/pages/welcome_page.dart';
import 'package:khookbook/routes.dart';
import 'package:khookbook/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // initialize FlutterFire
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Khookbooky',
      theme: MaterialTheme(ThemeData.light().textTheme).light(),
      darkTheme: MaterialTheme(ThemeData.dark().textTheme).dark(),
      initialRoute: WelcomePage.id,
      routes: {
        /*MealPage.id: (context) => MealPage(mealId: '52874'),*/
        // TODO: Remove after 'tasting...'
        // TODO: Use different appbar title depending on screen size
        CategoryPage.id: (context) => CategoryPage(title: 'Recipe Categories'),
        SignInPage.id: (context) =>
            SignInPage(title: 'Sign In to your account'),
        SignUpPage.id: (context) => SignUpPage(title: 'Sign Up for an account'),
        WelcomePage.id: (context) =>
            WelcomePage(title: 'Welcome to Khookbook!'),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
