import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_page.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';

class NotificationData extends Equatable {
  final IconData? icon;
  final String? content;
  final String? buttonText;
  final VoidCallback? onPress;

  NotificationData({
    required this.icon,
    required this.content,
    required this.buttonText,
    required this.onPress,
  });

  @override
  List<Object?> get props => [icon, content, buttonText, onPress];
}

NotificationData processNotification(
    Notifications notification, BuildContext context) {
  IconData? icon;
  String? content;
  String? buttonText;
  VoidCallback? onPress = () {};
  switch (notification.notificationType) {
    case "Follow":
      icon = Icons.person_add;
      content = "";
      buttonText = "View Profile";
      String username = notification.relatedUser!.username!;
      onPress = () {
        Navigator.of(context).push(
          MaterialPageRoute(
            settings: RouteSettings(
              name: '/user-profile/$username',
            ),
            builder: (context) => UserProfile(
              username: username,
            ),
          ),
        );
      };
      break;
    case "Upvote Comments":
      icon = Icons.arrow_upward;
      content = notification.post!.title;
      buttonText = null;
      onPress = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name:
                  '/post-card-page/${notification.postId}/true/${notification.commentId}/true',
            ),
            builder: (context) => PostCardPage(
              postId: notification.postId!,
              commentId: notification.commentId,
              oneComment: true,
            ),
          ),
        );
      };
      break;
    case "Upvote Posts":
      icon = Icons.arrow_upward;
      content = notification.post!.title;
      buttonText = null;
      onPress = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name: '/post-card-page/${notification.postId}/true',
            ),
            builder: (context) => PostCardPage(
              postId: notification.postId!,
            ),
          ),
        );
      };
      break;

    case "Comment Reply":
      icon = Icons.reply;
      content = notification.comment!.content;
      buttonText = "Reply";
      onPress = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name:
                  '/post-card-page/${notification.postId}/true/${notification.commentId}/true',
            ),
            builder: (context) => PostCardPage(
              postId: notification.postId!,
              commentId: notification.commentId,
              oneComment: true,
            ),
          ),
        );
      };
      break;
    case "Comment":
      icon = Ionicons.chatbubble;
      content = notification.comment!.content;
      onPress = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name:
                  '/post-card-page/${notification.postId}/true/${notification.commentId}/true',
            ),
            builder: (context) => PostCardPage(
              postId: notification.postId!,
              commentId: notification.commentId,
              oneComment: true,
            ),
          ),
        );
      };
      break;
    case "community":
      icon = CupertinoIcons.bell;
      content = 'Recommended : ${notification.communityname}';
      buttonText = null;
      onPress = () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CommunityPage(
              communityName: notification.communityname!,
            ),
          ),
        );
      };
      break;
      case "mention":
      icon = CupertinoIcons.person;
      content = notification.comment!.content;
      buttonText = null;
      onPress = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name:
                  '/post-card-page/${notification.postId}/true/${notification.commentId}/true',
            ),
            builder: (context) => PostCardPage(
              postId: notification.postId!,
              commentId: notification.commentId,
              oneComment: true,
            ),
          ),
        );
      };
      break;
      case "Account Update":
      icon = Ionicons.ban;
      content = '';
      buttonText = null;
      onPress = () {};
      break;
    default:
      throw ArgumentError(
          'Invalid notification type: ${notification.notificationType}');
  }

  return NotificationData(
    icon: icon,
    content: content,
    buttonText: buttonText,
    onPress: onPress,
  );
}

String getNotificationType(Notifications notification) {
  switch (notification.notificationType) {
    case "follow":
      return "newFollowers";
    case "upvoteComments":
      return "upvotes";
    case "upvotePosts":
      return "upvotes";
    case "commentReply":
      return "repliesToComments";
    case "comment":
      return "commentsOnYourPost";
    default:
      return "other";
  }
}
