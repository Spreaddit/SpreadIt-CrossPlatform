import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();  

Future<bool> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  if (googleUser == null) {
    return false;
  }
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  await FirebaseAuth.instance.signInWithCredential(credential);
  return true;
}

Future<bool> signOutWithGoogle(BuildContext context) async {
  if (_googleSignIn.currentUser != null) {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
  }
  return true;
}
