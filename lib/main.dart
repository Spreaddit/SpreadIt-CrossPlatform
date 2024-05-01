import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';
import 'package:spreadit_crossplatform/routes/routes.dart';
import 'firebase_options.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/pages/homepage.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import "features/Sign_up/Presentaion/pages/start_up_page.dart";
import "package:spreadit_crossplatform/features/notifications/Presentation/pages/inbox_page.dart";
import './user_info.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final token = await messaging.getToken(
    vapidKey:
        'BDdxkpSfsZfMF7ZyPklut-xQVgp6HH8GkJnTRHXGlsGv6u3oDujnIiqPF9_iqq_POtjU8tLuEISutYyAiyZC7dw',
  );
  print(token);
  await UserSingleton().loadFromPrefs();
  runApp(SpreadIt());
}

class SpreadIt extends StatelessWidget {
  SpreadIt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: kIsWeb
          ? const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse},
            )
          : null,
      title: 'Spread It',
      theme: spreadItTheme,
      home: UserSingleton().user != null ? HomePage() : StartUpPage(),
      onGenerateRoute: (settings) {
        final List<String>? pathSegments = settings.name?.split('/');
        if (pathSegments == null || pathSegments.isEmpty) {
          return null;
        }

        if (pathSegments.contains('post-card-page') &&
            pathSegments.length >= 5) {
          final postId = pathSegments[pathSegments.length - 4];
          final isUserProfile = pathSegments[pathSegments.length - 3] == 'true';
          final commentId = pathSegments[pathSegments.length - 2];
          final oneComment = pathSegments[pathSegments.length - 1] == 'fa;se';

          return MaterialPageRoute(
            builder: (_) => PostCardPage(
              postId: postId,
              isUserProfile: isUserProfile,
              commentId: commentId,
              oneComment: oneComment,
            ),
          );
        } else if (pathSegments.contains('user-profile-page') &&
            pathSegments.length == 2) {
          final username = pathSegments[pathSegments.length - 1];

          return MaterialPageRoute(
            builder: (_) => UserProfile(
              username: username,
            ),
          );
        }
        return null;
      },
      routes: generateRoutes(),
    );
  }
}
