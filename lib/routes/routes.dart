import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/account_settings_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/add_password_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/settings.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/presentation/blocked_accounts_page.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/pages/chat_page.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/pages/new_chat_page.dart';
import 'package:spreadit_crossplatform/features/create_a_community/presentation/pages/create_a_community_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/final_content_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/post_to_community_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/primary_content_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/rules_page.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/pages/edit_comment_page.dart';
import 'package:spreadit_crossplatform/features/forget_password/presentation/pages/forget_password_main.dart';
import 'package:spreadit_crossplatform/features/forget_username/presentation/pages/forget_username.dart';
import 'package:spreadit_crossplatform/features/history_page/history_page.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/pages/homepage.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/top_bar.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/presentation/pages/add_muted_user_page.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/presentation/pages/muted_user_page.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/pages/reset_password_main.dart';
import 'package:spreadit_crossplatform/features/saved/presentation/page/saved_page.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/createusername.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/email_screen.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/log_in_page.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/sign_up_page.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/start_up_page.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/edit_profile.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/follower_page.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/presentation/pages/muted_communities_page.dart';

import '../features/Account_Settings/presentation/pages/manage_notifications_page.dart';

Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
  final List<String>? pathSegments = settings.name?.split('/');
  if (pathSegments == null || pathSegments.isEmpty) {
    return null;
  }

  if (pathSegments.contains('post-card-page') && pathSegments.length >= 3) {
    final postId = pathSegments[pathSegments.length - 1];

    return MaterialPageRoute(
      builder: (_) => PostCardPage(postId: postId),
    );
  } else if (pathSegments.contains('chatroom')) {
    final chatId = pathSegments[pathSegments.length - 2];
    final chatroomName = pathSegments[pathSegments.length - 1];
    return MaterialPageRoute(
      builder: (_) => ChatPage(
        id: chatId,
        chatroomName: chatroomName,
      ),
    );
  } else if (pathSegments.contains('moderators') &&
      pathSegments.contains('community')) {
    final communityName = pathSegments[pathSegments.length - 1];
    // return MaterialPageRoute(
    //   builder: (_) => ModeratorsPage(
    //     communityName: communityName,
    //   ),
    // );
  }

  return null;
};

Map<String, WidgetBuilder> generateRoutes() {
  return {
    '/start-up-page': (context) => StartUpPage(),
    '/log-in-page': (context) => LogInScreen(),
    '/sign-up-page': (context) => SignUpScreen(),
    '/create-username-page': (context) => CreateUsername(),
    '/forget-password': (context) => ForgetPassword(),
    '/forget-username': (context) => ForgetUsername(),
    '/email-verification': (context) => EmailSentPage(),
    '/home': (context) => ProtectedRoute(child: HomePage()),
    '/popular': (context) =>
        ProtectedRoute(child: HomePage(currentPage: CurrentPage.popular)),
    '/discover': (context) =>
        ProtectedRoute(child: HomePage(currentPage: CurrentPage.discover)),
    '/chat-rooms': (context) =>
        ProtectedRoute(child: HomePage(currentPage: CurrentPage.chat)),
    '/new-chat': (context) => ProtectedRoute(child: NewChatPage()),
    '/all': (context) =>
        ProtectedRoute(child: HomePage(currentPage: CurrentPage.all)),
    '/create_a_community': (context) =>
        ProtectedRoute(child: CreateCommunityPage()),
    '/history': (context) => ProtectedRoute(child: HistoryPage()),
    '/settings': (context) => ProtectedRoute(child: SettingsPage()),
    '/settings/account-settings': (context) =>
        ProtectedRoute(child: AccountSettingsPage()),
    '/settings/account-settings/blocked_accounts': (context) =>
        ProtectedRoute(child: BlockedAccountsPage()),
    '/settings/account-settings/manage-notifications': (context) =>
        ProtectedRoute(child: NotificationsPageUI()),
    '/settings/account-settings/change-password': (context) =>
        ProtectedRoute(child: ResetPassword()),
    '/post-to-community': (context) => ProtectedRoute(
          child: Builder(
            builder: (context) {
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
          ),
        ),
    '/saved': (context) => ProtectedRoute(child: SavedPage()),
    '/user-profile': (context) => ProtectedRoute(child: UserProfile()),
    '/edit-profile': (context) => ProtectedRoute(child: EditProfilePage()),
    '/edit_comment': (context) => ProtectedRoute(child: EditComment()),
    '/settings/account-settings/add-password': (context) =>
        ProtectedRoute(child: AddPasswordPage()),
    '/muted-commuinties': (context) =>  ProtectedRoute(child: MutedCommunityPage()),
    '/muted-users': (context) =>  ProtectedRoute(child: MutedUsersPage()),
    '/edit-muted-user': (context) =>  ProtectedRoute(child: EditMutedUserPage()),
    '/followers-page': (context) =>  ProtectedRoute(child:FollowUsersPage()),
    '/final-content-page': (context) => ProtectedRoute(
          child: Builder(
            builder: (context) {
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
          ),
        ),
    '/primary-content-page': (context) => ProtectedRoute(child: CreatePost()),
    '/rules': (context) => ProtectedRoute(
          child: Builder(
            builder: (context) {
              final args = ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
              final communityRules = args['communityRules'] as List<Rule?>?;
              return CommunityRules(
                communityRules: communityRules ?? [],
              );
            },
          ),
        ),
  };
}

class ProtectedRoute extends StatelessWidget {
  final Widget child;

  const ProtectedRoute({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkIfUserLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final bool isLoggedIn = snapshot.data ?? false;
          return isLoggedIn ? child : StartUpPage();
        }
      },
    );
  }

  Future<bool> checkIfUserLoggedIn() async {
    if (UserSingleton().isloggedIn != null) {
      return UserSingleton().isloggedIn!;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString('userSingleton');
    return userDataJson != null;
  }
}
