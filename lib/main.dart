import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
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
            pathSegments.length >= 3) {
          final postId = pathSegments[pathSegments.length - 2];
          final isUserProfile = pathSegments[pathSegments.length - 1] == 'true';

          return MaterialPageRoute(
            builder: (_) =>
                PostCardPage(postId: postId, isUserProfile: isUserProfile),
          );
        }
        return null;
      },
      routes: generateRoutes(),
    );
  }
}
