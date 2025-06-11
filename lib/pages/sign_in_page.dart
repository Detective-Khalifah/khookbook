import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:khookbook/widgets/rounded_button.dart";
import "package:khookbook/pages/category_page.dart";
import "package:khookbook/utilities/constants.dart";
import "package:khookbook/utilities/validators.dart";
import "package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:khookbook/providers/auth_provider.dart";

class SignInPage extends HookConsumerWidget {
  static const String id = "sign_in";
  final String title;

  SignInPage({super.key, required this.title});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  late User signedInUser;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.rockSalt(color: Color(0xFFFFE5C6)),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: authState.isLoading,
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
              TextFormField(
                validator: (email) {
                  if (email != null) {
                    return validateEmail(email) ? null : "Invalid email";
                  } else {
                    return "Email is required";
                  }
                },
                controller: _emailController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your e-mail",
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: kTextFieldDecoration.copyWith(
                  hintText: "Enter your password.",
                ),
              ),
              SizedBox(height: 24.0),
              if (authState.error != null)
                Text(authState.error!, style: TextStyle(color: Colors.red)),
              RoundedButton(
                colour: Colors.deepOrangeAccent,
                label: "Sign in",
                onPressed: () async {
                  await authNotifier.signIn(
                    _emailController.text,
                    _passwordController.text,
                  );
                  if (ref.read(authNotifierProvider).error == null) {
                    Navigator.pushNamed(context, CategoryPage.id);
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
