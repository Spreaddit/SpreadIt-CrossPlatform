import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/account_settings_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/manage_notifications_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/settings.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/final_content_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/post_to_community_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/test_page.dart';
import 'package:spreadit_crossplatform/features/forget_username/presentation/pages/forget_username.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/pages/reset_password_main.dart';
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
      title: 'Spread It',
      theme: spreadItTheme,
      home: FinalCreatePost(
        title: '', 
        content: '', 
        pollOptions: [], 
        selectedDay: 1,
        isLinkAdded: false, 
        community: [{
          'communityName': 'r/AskReddit', 
          'communityIcon': './assets/images/LogoSpreadIt.png',
          'communityRules' : {
            'title': 'hate is not tolerated',
            'description': 'yarab nekhlas baa ana zhe2t men om el bta3 da',
            }
          }
        ]
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/start-up-page': (context) => StartUpPage(),
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
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return PostToCommunity(
            title: args['title'],
            content: args['content'],
            link: args['link'],
            image: args['image'],
            video: args['video'],
            pollOptions: args['pollOptions'],
            selectedDay:args['selectedDay'],
            createPoll: args['createPoll'],
            isLinkAdded: args['isLinkAdded'],
          );
        },    
        '/final-content-page': (context) { 
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return FinalCreatePost(
            title: args['title'],
            content: args['content'],
            link: args['link'],
            image: args['image'],
            video: args['video'],
            pollOptions: args['pollOptions'],
            selectedDay:args['selectedDay'],
            isLinkAdded: args['isLinkAdded'],
            community : args['community'],
          );
        },
        '/primary-content-page': (context) => CreatePost(),
        '/rules': (context) { 
          final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
          return CommunityRules(
            communityRules : args['communityRules'],
          );
        }
      },
    );
  }
}
