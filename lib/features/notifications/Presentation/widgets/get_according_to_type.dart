import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_page.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';

/// Data class representing a notification with its icon, content, button text, and onPress callback.
class NotificationData extends Equatable {
  /// The icon data representing the notification.
  final IconData? icon;

  /// The text content of the notification.
  final String? content;

  /// Text for the button associated with the notification (if any).
  final String? buttonText;

  /// Callback function to be executed when the notification is pressed.
  final VoidCallback? onPress;

  /// Constructs a [NotificationData] instance with the given parameters.
  NotificationData({
    required this.icon,
    required this.content,
    required this.buttonText,
    required this.onPress,
  });

  @override
  List<Object?> get props => [icon, content, buttonText, onPress];
}

/// Navigates to the post feed page with specific parameters.
void navigateToPostFeed(
    BuildContext context, String postId, String? commentId, bool oneComment) {
  Navigator.push(
    context,
    MaterialPageRoute(
      settings: RouteSettings(
        name: '/post-card-page/$postId/true/$commentId/$oneComment',
      ),
      builder: (context) => PostCardPage(
        postId: postId,
        commentId: commentId,
        oneComment: oneComment,
      ),
    ),
  );
}

/// Processes a notification and returns corresponding NotificationData.
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
        navigateToPostFeed(
            context, notification.postId!, notification.commentId!, true);
      };
      break;
    case "Upvote Posts":
      icon = Icons.arrow_upward;
      content = notification.post!.title;
      buttonText = null;
      onPress = () {
        navigateToPostFeed(context, notification.postId!, null, false);
      };
      break;

    case "Comment Reply":
      icon = Icons.reply;
      content = notification.comment!.content;
      buttonText = "Reply";
      onPress = () {
        navigateToPostFeed(
            context, notification.postId!, notification.commentId!, true);
      };
      break;
    case "Comment":
      icon = Ionicons.chatbubble;
      content = notification.comment!.content;
      onPress = () {
        navigateToPostFeed(
            context, notification.postId!, notification.commentId!, true);
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
        navigateToPostFeed(
            context, notification.postId!, notification.commentId!, true);
      };
      break;
    case "Account Update":
      icon = Ionicons.ban;
      content = '';
      buttonText = null;
      onPress = () {};
      break;
    case "Invite":
      icon = Ionicons.person;
      content = '';
      buttonText = 'Accept invitation';
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

/// Gets the notification type as a string based on the notification
/// Used to be able to disable notification type
String getNotificationType(Notifications notification) {
  switch (notification.notificationType) {
    case "Follow":
      return "newFollowers";
    case "Upvote Comments":
      return "upvotes";
    case "Upvote Posts":
      return "upvotes";
    case "Comment Reply":
      return "repliesToComments";
    case "Comment":
      return "commentsOnYourPost";
    default:
      return "other";
  }
}
