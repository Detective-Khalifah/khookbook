import "package:animated_text_kit/animated_text_kit.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:khookbook/widgets/rounded_button.dart";
import "package:khookbook/pages/home_page.dart";
import "package:khookbook/pages/sign_in_page.dart";
import "package:khookbook/pages/sign_up_page.dart";

class WelcomePage extends StatelessWidget {
  static const String id = "welcome";
  final String title;

  const WelcomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.rockSalt(color: Color(0xFFFFE5C6)),
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
                tag: "cooking_pot",
                child: SvgPicture.asset(
                  "assets/images/orion_cooking_pot.svg",
                  height: 200,
                  width: 200,
                  semanticsLabel: "An image of a pot",
                ),
              ),
            ),
            SizedBox(
              height:
                  Theme.of(context).textTheme.displayLarge!.fontSize! *
                  1.2, // headlineLarge also works as long as fontSize is set to 24
              width: 200.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 24.0,
                  fontFamily: "Festive",
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: Color(0xFFFFE5C6),
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Khalifah's Cookbook",
                      cursor: "🍲",
                      speed: const Duration(milliseconds: 500),
                      textAlign: TextAlign.center,
                    ), // "\u{1F372}"
                    TypewriterAnimatedText(
                      "Khookbook!",
                      cursor: "🍲",
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 250),
                    ),
                  ],
                  displayFullTextOnTap: true,
                  repeatForever: true,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            RoundedButton(
              colour: Colors.deepOrangeAccent,
              label: "Sign In",
              onPressed: () {
                Navigator.pushNamed(context, SignInPage.id);
              },
            ),
            RoundedButton(
              colour: Colors.deepOrange,
              label: "Sign Up",
              onPressed: () {
                Navigator.pushNamed(context, SignUpPage.id);
              },
            ),
            RoundedButton(
              colour: Colors.orangeAccent,
              label: "Bite a Taste",
              onPressed: () {
                Navigator.pushNamed(context, HomePage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
