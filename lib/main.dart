import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './features/Sign_up/Presentaion/sign_up_page.dart';
import './features/Sign_up/Presentaion/log_in_page.dart';
import "./features/Sign_up/Presentaion/start_up_page.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const SpreadIt());
}

class SpreadIt extends StatelessWidget {
  const SpreadIt({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spread It',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StartUpPage(),
      routes: {
        '/start-up-page': (context) => StartUpPage(), 
        '/log-in-page': (context) => LogInScreen(),
        '/sign-up-page': (context) => SignUpScreen(),
      },
    );
  }
}

