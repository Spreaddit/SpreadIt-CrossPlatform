import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/account_settings_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/manage_notifications_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/settings.dart';
import 'package:spreadit_crossplatform/features/forget_username/presentation/pages/forget_username.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/post_caard.dart';
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

Comment C = Comment(
    commentId: 0,
    userId: "hafagab",
    postId: "bzjnnjamz",
    username: "rehab/u",
    profilePic: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    votesCount: 5,
    date: DateTime(2024, 3, 1),
    content:
        "Rehab is an extraordinary individual whose presence radiates warmth and inspiration. With her boundless energy and unwavering determination, she navigates through life's challenges with grace and resilience. Her passion for learning and creativity knows no bounds, as she constantly seeks to broaden her horizons and make a positive impact on the world around her. Farida's kindness and compassion touch the hearts of everyone she meets, leaving a lasting impression that transcends time and space. She truly embodies the essence of greatness, and her journey serves as a beacon of hope and inspiration for us all.");

Post P = Post(
    postId: 1,
    username: "Ahmed/m",
    userId: "vfhj",
    date: DateTime(2024, 3, 1),
    headline: "SW WILL BE MY END",
    votesCount: 8,
    sharesCount: 9,
    commentsCount: 5,
    description:
        "This is my last straw, I quit I am gonna kms and it's your fault I hate this subject af I will never ever choose this track by any means </3.",
    profilePic:
        "https://static.vecteezy.com/system/resources/previews/008/385/797/non_2x/reddit-social-media-icon-abstract-logo-design-illustration-free-vector.jpg");

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
      home: PostCardPage(post: P), //StartUpPage(),
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
      },
    );
  }
}
