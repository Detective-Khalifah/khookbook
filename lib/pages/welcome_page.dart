import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khookbook/components/rounded_button.dart';
import 'package:khookbook/pages/category_page.dart';
import 'package:khookbook/pages/sign_in_page.dart';
import 'package:khookbook/pages/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome';
  final String title;

  WelcomePage({Key? key, required this.title}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.rockSalt(
            color: Color(0xFFFFE5C6),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'cooking_pot',
                child: SvgPicture.asset(
                  'assets/images/orion_cooking_pot.svg',
                  height: 200,
                  width: 200,
                  semanticsLabel: 'An image of a pot',
                ),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Festive',
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: Color(0xFFFFE5C6)),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Khalifah\'s Cookbook',
                        cursor: '🍲',
                        speed: const Duration(milliseconds: 500),
                        textAlign: TextAlign.center), // "\u{1F372}"
                    TypewriterAnimatedText('Khookbook!',
                        cursor: '🍲',
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 250)),
                  ],
                  displayFullTextOnTap: true,
                  repeatForever: true,
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            RoundedButton(
                colour: Colors.deepOrangeAccent,
                label: 'Login',
                onPressed: () {
                  Navigator.pushNamed(context, SignInPage.id);
                }),
            RoundedButton(
                colour: Colors.deepOrange,
                label: 'Sign Up',
                onPressed: () {
                  Navigator.pushNamed(context, SignUpPage.id);
                }),
            RoundedButton(
                colour: Colors.orangeAccent,
                label: 'Take a Tour',
                onPressed: () {
                  Navigator.pushNamed(context, CategoryPage.id);
                })
          ],
        ),
      ),
    );
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }
}
