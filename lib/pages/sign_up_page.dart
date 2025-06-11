import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:khookbook/widgets/rounded_button.dart";
import "package:khookbook/pages/category_page.dart";
import "package:khookbook/utilities/constants.dart";
import "package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart";

class SignUpPage extends StatefulWidget {
  static const String id = "sign_up";
  final String title;

  const SignUpPage({super.key, required this.title});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;

  late String email, passkey;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.rockSalt(color: Color(0xFFFFE5C6)),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                    height: 320.0,
                    width: 400,
                  ),
                ),
              ),
              SizedBox(height: 48.0),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your e-mail",
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  passkey = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your password",
                ),
              ),
              SizedBox(height: 24.0),
              RoundedButton(
                colour: Colors.deepOrange,
                label: "Sign Up",
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: passkey,
                    );
                    print(email + " $passkey");
                    if (newUser != null) {
                      Navigator.pushNamed(context, CategoryPage.id);

                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } catch (FANU) {
                    print(FANU);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
