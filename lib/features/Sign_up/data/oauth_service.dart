import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:spreadit_crossplatform/user_info.dart";


/// Google sign-in instance.
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

/// Function to sign in with Google.
Future<String> signInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  if (googleUser == null) {
    return "";
  }
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  var accessToken=credential.accessToken!;
  print(credential);
  await FirebaseAuth.instance.signInWithCredential(credential);
  final currentUser = FirebaseAuth.instance.currentUser;
  String userId = currentUser!.uid;
   UserSingleton().setGoogleInfo(accessToken , currentUser!.email!);
   UserSingleton().setUserId(userId);
  return accessToken;
}

/// Function to sign out with Google.
Future<bool> signOutWithGoogle(BuildContext context) async {
  User? currentUser = _auth.currentUser;
  if (currentUser != null) {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await _auth.signOut();
    print('Signned out from google');
  }
  return true;
}

Future<void> signInwithEmailandPassword(String email, String password) async {
 try {
  UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
  String userId = userCredential.user!.uid;
  print('userid $userId');
  UserSingleton().setUserId(userId);
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
}


Future<void> loginWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    String userId = userCredential.user!.uid;
    UserSingleton().setUserId(userId);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  } catch (e) {
    print(e);
  }
}