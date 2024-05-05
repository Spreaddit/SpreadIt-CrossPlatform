import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/modtools_page.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/subscribe_notifications.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
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
    return MaterialApp(
      scrollBehavior: !isAndroid
          ? const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse},
            )
          : null,
      title: 'Spread It',
      theme: spreadItTheme,
      home: UserSingleton().user != null ? HomePage() : StartUpPage(),
      //home: ModtoolsPage(communityName: "hardware"),
      //home: CommunityPage(communityName: "hardware"),
      onGenerateRoute: onGenerateRoute,
      routes: generateRoutes(),
    );
  }
}
