import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/account_settings_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/add_password_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/manage_notifications_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/settings.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/final_content_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/post_to_community_page.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/pages/edit_comment_page.dart';
import 'package:spreadit_crossplatform/features/forget_username/presentation/pages/forget_username.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/top_bar.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/edit_moderators_permissions.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/invite_moderator_page.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/moderators-page.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/presentation/pages/post_types_page.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/pages/reset_password_main.dart';
import 'features/saved/presentation/page/saved_page.dart';
import 'features/user_profile/presentation/pages/edit_profile.dart';
import 'firebase_options.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/pages/homepage.dart';
import 'package:spreadit_crossplatform/features/history_page/history_page.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import 'features/forget_password/presentation/pages/forget_password_main.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/presentation/blocked_accounts_page.dart';
import 'package:spreadit_crossplatform/features/create_a_community/presentation/pages/create_a_community_page.dart';
import 'features/Sign_up/Presentaion/pages/sign_up_page.dart';
import 'features/Sign_up/Presentaion/pages/log_in_page.dart';
import "features/Sign_up/Presentaion/pages/start_up_page.dart";
import 'features/Sign_up/Presentaion/pages/createusername.dart';
import 'features/create_post/presentation/pages/primary_content_page.dart';
import 'features/create_post/presentation/pages/rules_page.dart';
import 'features/user_profile/presentation/pages/user_profile.dart';
import './user_info.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/*void main() async {
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
      home: FutureBuilder<bool>(
        future: _checkIfUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final bool loggedIn = snapshot.data!;
            return loggedIn ? HomePage() : StartUpPage();
          }
        },
      ),
      onGenerateRoute: (settings) {
        final List<String>? pathSegments = settings.name?.split('/');
        print(pathSegments);
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
      },
      routes: {
        '/start-up-page': (context) => StartUpPage(),
        '/home': (context) => HomePage(),
        '/popular': (context) => HomePage(
              currentPage: CurrentPage.popular,
            ),
        '/discover': (context) => HomePage(
              currentPage: CurrentPage.discover,
            ),
        '/all': (context) => HomePage(
              currentPage: CurrentPage.all,
            ),
        '/log-in-page': (context) => LogInScreen(),
        '/sign-up-page': (context) => SignUpScreen(),
        '/create-username-page': (context) => CreateUsername(),
        '/create_a_community': (context) => CreateCommunityPage(),
        '/history': (context) => HistoryPage(),
        '/settings': (context) => SettingsPage(),
        '/settings/account-settings': (context) => AccountSettingsPage(),
        '/settings/account-settings/blocked_accounts': (context) =>
            BlockedAccountsPage(),
        '/forget-password': (context) => ForgetPassword(),
        '/forget-username': (context) => ForgetUsername(),
        '/settings/account-settings/manage-notifications': (context) =>
            NotificationsPageUI(),
        '/settings/account-settings/change-password': (context) =>
            ResetPassword(),
        '/post-to-community': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return PostToCommunity(
            title: args['title'],
            content: args['content'],
            link: args['link'],
            image: args['image'],
            imageWeb: args['imageWeb'],
            video: args['video'],
            videoWeb: args['videoWeb'],
            pollOptions: args['pollOptions'],
            selectedDay: args['selectedDay'],
            createPoll: args['createPoll'],
            isLinkAdded: args['isLinkAdded'],
          );
        },
        '/final-content-page': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return FinalCreatePost(
            title: args['title'],
            content: args['content'],
            link: args['link'],
            image: args['image'],
            imageWeb: args['imageWeb'],
            video: args['video'],
            videoWeb: args['videoWeb'],
            pollOptions: args['pollOptions'],
            selectedDay: args['selectedDay'],
            isLinkAdded: args['isLinkAdded'],
            community: args['community'],
          );
        },
        '/primary-content-page': (context) => CreatePost(),
        '/rules': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return CommunityRules(
            communityRules: args['communityRules'],
          );
        },
        '/saved': (context) => SavedPage(),
        '/user-profile': (context) => UserProfile(),
        '/edit-profile': (context) => EditProfilePage(),
        '/edit_comment': (context) => EditComment(),
        '/settings/account-settings/add-password': (context) =>
            AddPasswordPage(),
      },
    );
  }

  Future<bool> _checkIfUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString('userSingleton');
    return userDataJson != null;
  }
}
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: InviteModeratorPage(
          communityName:
              "communityName"), //ModeratorsPage(communityName: "community"), // ModeratorsPage(communityName: "community"), //StartUpPage(),
      onGenerateRoute: (settings) {
        final List<String>? pathSegments = settings.name?.split('/');
        print(pathSegments);
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
      },
      routes: {
        '/home': (context) => HomePage(),
        '/popular': (context) => HomePage(
              currentPage: CurrentPage.popular,
            ),
        '/discover': (context) => HomePage(
              currentPage: CurrentPage.discover,
            ),
        // '/all': (context) => AllPage(),
        '/log-in-page': (context) => LogInScreen(),
        '/sign-up-page': (context) => SignUpScreen(),
        '/create-username-page': (context) => CreateUsername(),
        '/create_a_community': (context) => CreateCommunityPage(),
        '/history': (context) => HistoryPage(),
        '/settings': (context) => SettingsPage(),
        '/settings/account-settings': (context) => AccountSettingsPage(),
        '/settings/account-settings/blocked_accounts': (context) =>
            BlockedAccountsPage(),
        '/forget-password': (context) => ForgetPassword(),
        '/forget-username': (context) => ForgetUsername(),
        '/settings/account-settings/manage-notifications': (context) =>
            NotificationsPageUI(),
        '/settings/account-settings/change-password': (context) =>
            ResetPassword(),
        '/post-to-community': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return PostToCommunity(
            title: args['title'],
            content: args['content'],
            link: args['link'],
            image: args['image'],
            imageWeb: args['imageWeb'],
            video: args['video'],
            videoWeb: args['videoWeb'],
            pollOptions: args['pollOptions'],
            selectedDay: args['selectedDay'],
            createPoll: args['createPoll'],
            isLinkAdded: args['isLinkAdded'],
          );
        },
        '/final-content-page': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return FinalCreatePost(
            title: args['title'],
            content: args['content'],
            link: args['link'],
            image: args['image'],
            imageWeb: args['imageWeb'],
            video: args['video'],
            videoWeb: args['videoWeb'],
            pollOptions: args['pollOptions'],
            selectedDay: args['selectedDay'],
            isLinkAdded: args['isLinkAdded'],
            community: args['community'],
          );
        },
        '/primary-content-page': (context) => CreatePost(),
        '/rules': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return CommunityRules(
            communityRules: args['communityRules'],
          );
        },
        '/saved': (context) => SavedPage(),
        '/user-profile': (context) => UserProfile(),
        '/edit-profile': (context) => EditProfilePage(),
        '/edit_comment': (context) => EditComment(),
        '/settings/account-settings/add-password': (context) =>
            AddPasswordPage(),
      },
    );
  }
}
