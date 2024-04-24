import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/account_settings_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/add_password_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/settings.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/presentation/blocked_accounts_page.dart';
import 'package:spreadit_crossplatform/features/create_a_community/presentation/pages/create_a_community_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/final_content_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/post_to_community_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/primary_content_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/rules_page.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/pages/edit_comment_page.dart';
import 'package:spreadit_crossplatform/features/forget_password/presentation/pages/forget_password_main.dart';
import 'package:spreadit_crossplatform/features/forget_username/presentation/pages/forget_username.dart';
import 'package:spreadit_crossplatform/features/history_page/history_page.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/pages/homepage.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/top_bar.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/pages/reset_password_main.dart';
import 'package:spreadit_crossplatform/features/saved/presentation/page/saved_page.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/createusername.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/log_in_page.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/sign_up_page.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/start_up_page.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/edit_profile.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';

import '../features/Account_Settings/presentation/pages/manage_notifications_page.dart';

class RouteManager {
  static const List<String> _routesnotRequiringAuthentication = [
    '/forget-password',
    '/forget-username',
    '/start-up-page',
    '/log-in-page',
    '/sign-up-page',
  ];

  static Future<bool> checkIfUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString('userSingleton');
    return userDataJson != null;
  }

  static bool _requiresAuthentication(String routeName) {
    return !_routesnotRequiringAuthentication.contains(routeName);
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final List<String>? pathSegments = settings.name?.split('/');

    if (pathSegments == null || pathSegments.isEmpty) {
      return MaterialPageRoute(builder: (context) => Container());
    }
  
    switch (settings.name) {
      case '/start-up-page':
        return MaterialPageRoute(builder: (context) => StartUpPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/popular':
        return MaterialPageRoute(
            builder: (context) => HomePage(currentPage: CurrentPage.popular));
      case '/discover':
        return MaterialPageRoute(
            builder: (context) => HomePage(currentPage: CurrentPage.discover));
      case '/all':
        return MaterialPageRoute(
            builder: (context) => HomePage(currentPage: CurrentPage.all));
      case '/log-in-page':
        return MaterialPageRoute(builder: (context) => LogInScreen());
      case '/sign-up-page':
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case '/create-username-page':
        return MaterialPageRoute(builder: (context) => CreateUsername());
      case '/create_a_community':
        return MaterialPageRoute(builder: (context) => CreateCommunityPage());
      case '/history':
        return MaterialPageRoute(builder: (context) => HistoryPage());
      case '/settings':
        return MaterialPageRoute(builder: (context) => SettingsPage());
      case '/settings/account-settings':
        return MaterialPageRoute(builder: (context) => AccountSettingsPage());
      case '/settings/account-settings/blocked_accounts':
        return MaterialPageRoute(builder: (context) => BlockedAccountsPage());
      case '/forget-password':
        return MaterialPageRoute(builder: (context) => ForgetPassword());
      case '/forget-username':
        return MaterialPageRoute(builder: (context) => ForgetUsername());
      case '/settings/account-settings/manage-notifications':
        return MaterialPageRoute(builder: (context) => NotificationsPageUI());
      case '/settings/account-settings/change-password':
        return MaterialPageRoute(builder: (context) => ResetPassword());
      case '/post-to-community':
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => PostToCommunity(
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
                ));
      case '/final-content-page':
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => FinalCreatePost(
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
                ));
      case '/primary-content-page':
        return MaterialPageRoute(builder: (context) => CreatePost());
      case '/rules':
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => CommunityRules(
                  communityRules: args['communityRules'],
                ));
      case '/saved':
        return MaterialPageRoute(builder: (context) => SavedPage());
      case '/user-profile':
        return MaterialPageRoute(builder: (context) => UserProfile());
      case '/edit-profile':
        return MaterialPageRoute(builder: (context) => EditProfilePage());
      case '/edit_comment':
        return MaterialPageRoute(builder: (context) => EditComment());
      case '/settings/account-settings/add-password':
        return MaterialPageRoute(builder: (context) => AddPasswordPage());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(body: Text('Route not found')),
        );
    }
  }
 static Route<dynamic>? generateAuthenticatedRoute(RouteSettings settings , bool loggedIn) {
  if (_requiresAuthentication(settings.name!)) {

    if (loggedIn) {
      return generateRoute(settings)!;
    } else {
      return MaterialPageRoute(builder: (context) => StartUpPage());
    }
  } else {
    return generateRoute(settings)!;
  }
}


}
