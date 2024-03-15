import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


Future<void> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) {
    return;
  }
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  await FirebaseAuth.instance.signInWithCredential(credential);
  Navigator.of(context).pushNamed('/log-in-page'); // should be homepage
}

void signOutWithGoogle(BuildContext context) {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  _googleSignIn.signOut();
  Navigator.of(context).pushNamed('/start-up-page'); // Ensure correct route setup
}

