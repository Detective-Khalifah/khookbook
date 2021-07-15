import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khookbook/components/rounded_button.dart';
import 'package:khookbook/pages/sign_up_page.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome';
  final String title;

  WelcomePage({Key? key, required this.title}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
                  totalRepeatCount: 5,
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            RoundedButton(
                colour: Colors.deepOrangeAccent,
                label: 'Login',
                onPressed: () {}),
            RoundedButton(
                colour: Colors.deepOrange,
                label: 'Sign Up',
                onPressed: () {
                  Navigator.pushNamed(context, SignUpPage.id);
                }),
          ],
        ),
      ),
    );
  }
}
