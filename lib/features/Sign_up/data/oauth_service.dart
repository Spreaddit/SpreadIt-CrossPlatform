import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Google sign-in instance.
final GoogleSignIn _googleSignIn = GoogleSignIn();  

/// Function to sign in with Google.
Future<String> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  if (googleUser == null) {
    return "";
  }
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  var accessToken=credential.accessToken!;
  await FirebaseAuth.instance.signInWithCredential(credential);
  return accessToken;
}

/// Function to sign out with Google.
Future<bool> signOutWithGoogle(BuildContext context) async {
  if (_googleSignIn.currentUser != null) {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
  }
  return true;
}
