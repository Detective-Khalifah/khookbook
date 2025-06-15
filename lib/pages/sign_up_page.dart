import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:khookbook/providers/auth_provider.dart" show authProvider;
import "package:khookbook/widgets/rounded_button.dart";
import "package:khookbook/utilities/constants.dart";
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpPage extends HookConsumerWidget {
  static const String id = "sign_up";
  final String title;

  SignUpPage({super.key, required this.title});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider.notifier);

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
                  height: 320.0,
                  width: 400,
                ),
              ),
            ),
            SizedBox(height: 48.0),
            TextField(
              controller: _emailController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                // email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: "Enter your e-mail",
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                // passkey = value;
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
                await auth.signUp(
                  context,
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
