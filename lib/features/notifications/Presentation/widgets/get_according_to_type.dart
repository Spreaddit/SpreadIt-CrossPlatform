import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_page.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';

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
    case "follow":
      icon = Icons.person_add;
      content = "";
      buttonText = "View Profile";
      String username = notification.relatedUser!.username!;
      onPress = () {
        Navigator.of(context).pushNamed(
          '/user-profile',
          arguments: {
            'username': username,
          },
        );
      };
      break;
    case "upvoteComments":
      icon = Icons.thumb_up;
      content = notification.comment!.content;
      buttonText = "View Comment";
      onPress = () {
        //need to scroll to comment
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name: '/post-card-page/${notification.postId}/true/${notification.commentId}/true',
            ),
            builder: (context) => PostCardPage(
              postId: notification.postId!,
              isUserProfile: true,
              commentId: notification.commentId,
              oneComment: true,
            ),
          ),
        );
      };
      break;
    case "upvotePosts":
      icon = Icons.thumb_up;
      content = notification.post!.title;
      buttonText = "View Post";
      onPress = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name: '/post-card-page/${notification.postId}/true',
            ),
            builder: (context) => PostCardPage(
              postId: notification.postId!,
              isUserProfile: true,
            ),
          ),
        );
      };
      break;

    case "commentReply":
      icon = Icons.reply;
      content = notification.comment!.content;
      buttonText = "View Comment";
      onPress = () {
        //need to scroll ll comment
         Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name: '/post-card-page/${notification.postId}/true/${notification.commentId}/true',
            ),
            builder: (context) => PostCardPage(
              postId: notification.postId!,
              isUserProfile: true,
              commentId: notification.commentId,
              oneComment: true,
            ),
          ),
        );
      };
      break;
    case "comment":
      icon = Icons.comment;
      content = notification.comment!.content;
      buttonText = "View Comment";
      onPress = () {
        //need to scroll ll comment
         Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name: '/post-card-page/${notification.postId}/true/${notification.commentId}/true',
            ),
            builder: (context) => PostCardPage(
              postId: notification.postId!,
              isUserProfile: true,
              commentId: notification.commentId,
              oneComment: true,
            ),
          ),
        );
      };
      break;
    case "community":
      icon = Icons.comment;
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
