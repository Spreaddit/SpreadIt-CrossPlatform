import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';

class NotificationData {
  final IconData icon;
  final String content;
  final String buttonText;
  final VoidCallback onPress;

  NotificationData({
    required this.icon,
    required this.content,
    required this.buttonText,
    required this.onPress,
  });
}

NotificationData processNotification(Notifications notification) {
  IconData icon;
  String content;
  String buttonText;
  VoidCallback onPress = () {};
  switch (notification.notificationType) {
    case "newFollowers":
      icon = Icons.person_add;
      content = "";
      buttonText = "View Profile";
      onPress = () {
        // Go to user profile
      };
      break;
    case "mentions":
      icon = Icons.alternate_email;
      content = notification.comment!.content;
      buttonText = "View Mention";
      onPress = () {
        // Go to comment that you are mentioned in
      };
      break;
    case "upvotesComments":
      icon = Icons.thumb_up;
      content = notification.comment!.content;
      buttonText = "View Comment";
      onPress = () {
      // Set onPress callback to navigate to the commented post
      };
      break;
    case "upvotesPosts":
      icon = Icons.thumb_up;
      content = notification.post!.title;
      buttonText = "View Post";
      onPress = () {
      // Set onPress callback to navigate to the upvoted post
      };
      break;
    case "chatMessages":
      icon = Icons.message;
      content = "";
      buttonText = "Open Chat";
      onPress = () {
         // Set onPress callback to open the chat room
      };
      break;
    case "chatRequests":
      icon = Icons.message;
      content = "";
      buttonText = "Accept Request";
      onPress = () {
        // Set onPress callback to accept the chat request
      };
      break;
    case "repliesToComments":
      icon = Icons.reply;
      content = notification.comment!.content;
      buttonText = "View Comment";
      onPress = () {
        // Set onPress callback to navigate to the commented post
      };
      break;
    case "cakeDay":
      icon = Icons.cake;
      content = "Cake Day";
      buttonText = "Celebrate!";
      onPress = () {
        // Go to chat?
      };
      break;
    case "modNotifications":
      icon = Icons.security;
      content = "Moderator Notification";
      buttonText = "View";
      onPress = () {
              // Set onPress callback to navigate to the moderator panel
      };
      break;
    case "replies":
      icon = Icons.reply;
      content = notification.comment!.content;
      buttonText = "View";
      onPress = () {
      // Set onPress callback to navigate to the replied comment
      };
      break;
    case "invitations":
      icon = Icons.event;
      content = "";
      buttonText = "View";
      onPress = () {
      // Set onPress callback to view event details
      };
      break;
    case "posts":
      icon = Icons.post_add;
      content = notification.post!.title;
      buttonText = "View Post";
      onPress = () {
      // Set onPress callback to view the new post
      };
      break;
    case "comments":
      icon = Icons.comment;
      content = notification.comment!.content;
      buttonText = "View Comment";
      onPress = () {
      // Set onPress callback to navigate to the commented post
      };
      break;
    case "inboxMessages":
      icon = Icons.mail;
      content = "New Inbox Message";
      buttonText = "Open Inbox";
      onPress = () {
      // Set onPress callback to open the inbox
      };
      break;
    default:
      throw ArgumentError('Invalid notification type: ${notification.notificationType}');
  }

  return NotificationData(
    icon: icon,
    content: content,
    buttonText: buttonText,
    onPress: onPress,
  );
}
