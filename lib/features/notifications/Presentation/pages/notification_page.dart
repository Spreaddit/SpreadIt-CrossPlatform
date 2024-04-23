import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/get_notifications.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/get_according_to_type.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/notification_widget.dart';
import 'dart:math';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<Notifications> notification;
  var community = false;
  @override
  void initState() {
    super.initState();
    fetchnotificationsinfo();
  }

  void fetchnotificationsinfo() async {
    try {
      notification = await fetchNotifications();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Notifications>>(
      future: fetchNotifications(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoaderWidget(
            dotSize: 10,
            logoSize: 100,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<Notifications>? notifications = snapshot.data;
          return ListView.builder(
            itemCount: notifications!.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final data = processNotification(notification);
              return NotificationWidget(
                content: data.content,
                title: notification.content,
                profilePicUrl: notification.relatedUser.avatarUrl,
                date: dateToDuration(notification.createdAt),
                iconData: data.icon,
                buttonIcon: data.icon,
                buttonText: data.buttonText,
                onPressed: data.onPress,
                isRead: notification.isRead,
                followed: followed(notification.notificationType),
                community: getRandomBool(),

                ///To be changed later
              );
            },
          );
        }
      },
    );
  }
}

bool followed(String notificationType) {
  if (notificationType == "posts" || notificationType == "comments") {
    return true;
  }
  return false;
}

bool getRandomBool() {
  // Generate a random number between 0 and 1
  var random = Random();
  var randomNumber = random.nextDouble();

  // Return true if the random number is greater than or equal to 0.5, otherwise false
  return randomNumber >= 0.5;
}
