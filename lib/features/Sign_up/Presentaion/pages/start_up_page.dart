import 'package:flutter/material.dart';

import '../../../generic_widgets/snackbar.dart';
import '../../data/google_oauth.dart';
import "../../data/oauth_service.dart";
import '../../../generic_widgets/terms_and_cond_text.dart';
import '../../../generic_widgets/button.dart';

/// The startup page where users can either log in, sign up with email, or sign up with Google.
class StartUpPage extends StatelessWidget {
/// Navigates to the login page.
  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/log-in-page');
  }

/// Navigates to the sign-up page.
  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed('/sign-up-page');
  }

/// Handles sign-in with Google authentication.
  Future<void> handleSignIn(BuildContext context) async {
    String accesstoken = await signInWithGoogle(context);
    var responseCode = await googleOAuthApi(
      googleToken: accesstoken,
    );
    if (responseCode == 200) {
      Navigator.of(context).pushNamed('/home');
    } else if (responseCode == 400) {
      CustomSnackbar(content: "Invalid input").show(context);
    } else if (responseCode == 409) {
      CustomSnackbar(content: "User already exists").show(context);
    } else if (responseCode == 500) {
      CustomSnackbar(content: "Internal server error").show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  'assets/images/LogoSpreadIt.png',
                  width: 50,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'All your \n interests\nin one place',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Button(
                onPressed: () => navigateToSignUp(context),
                text: 'Continue with email',
                backgroundColor: Color(0xFFEFEFED),
                foregroundColor: Color(0xFF222222),
                prefixIcon: Icons.email,
              ),
              Button(
                onPressed: () => handleSignIn(context),
                text: 'Continue with Google',
                backgroundColor: Color(0xFFEFEFED),
                foregroundColor: Color(0xFF222222),
                imagePath: 'assets/images/GoogleLogo.png',
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 16,
                  left: 20,
                  right: 20,
                ),
                child: TermsAndCondText(),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                  onPressed: () => navigateToLogin(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a spredittor? ',
                        style: TextStyle(
                          color: Color(0xFF95A5A6),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}