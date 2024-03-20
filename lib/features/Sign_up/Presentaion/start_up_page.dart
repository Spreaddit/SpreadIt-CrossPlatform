import 'package:flutter/material.dart';

import "./widget/oauth_service.dart";
import './widget/terms_and_cond_text.dart';
import './widget/button.dart'; 

class StartUpPage extends StatelessWidget {

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/log-in-page');
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed('/sign-up-page');
  }

  Future<void> handleSignIn(BuildContext context) async {
  bool signedIn= await signInWithGoogle(context);
  if(signedIn) {
    Navigator.of(context).pushNamed('/log-in-page'); 
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }
}
