import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spreadit_crossplatform/routes/routes.dart';
import 'firebase_options.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/pages/homepage.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import "features/Sign_up/Presentaion/pages/start_up_page.dart";
import './user_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserSingleton().loadFromPrefs();
  bool isAndroid;
  try {
    isAndroid = Platform.isAndroid;
  } catch (e) {
    print('Error detecting platform: $e');
    isAndroid = false;
  }
  runApp(SpreadIt(isAndroid: isAndroid));
}

class SpreadIt extends StatelessWidget {
  final bool isAndroid;

  SpreadIt({required this.isAndroid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("hey");
    return MaterialApp(
      scrollBehavior: !isAndroid
          ? const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse},
            )
          : null,
      title: 'Spread It',
      theme: spreadItTheme,
      home: UserSingleton().user != null ? HomePage() : StartUpPage(),
      onGenerateRoute: onGenerateRoute,
      routes: generateRoutes(),
    );
  }
}
