import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/data/data_source/api_notifications_settings.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/hide_notifications.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/get_according_to_type.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/notification_widget.dart';

class NotificationPage extends StatefulWidget {

  List<Notifications> todayNotifications;
  List<Notifications> earlierNotifications;
  List<Notifications> notifications;
  final bool isAllRead;
  
   NotificationPage({
    Key? key,
    required this.todayNotifications,
    required this.earlierNotifications,
    required this.notifications,
    this.isAllRead=false,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}


class _NotificationPageState extends State<NotificationPage> {
  List<Notifications> todayNotifications = [];
  List<Notifications> earlierNotifications = [];
  List<Notifications> notifications = [];


  Map<String, dynamic> notificationsSettingsValues = {
    "newFollowers": false,
    "mentions": false,
    "inboxMessages": false,
    "chatMessages": false,
    "chatRequests": false,
    "repliesToComments": false,
    "cakeDay": false,
    "modNotifications": false,
    "commentsOnYourPost": false,
    "commentsYouFollow": false,
    "upvotes": false
  };

  @override
  void initState() {
    super.initState();
    notifications = widget.notifications;
    earlierNotifications= widget.earlierNotifications;
    todayNotifications = widget.todayNotifications;
    if(notifications.isNotEmpty)
    {
      print('notifications loaded sa7');
    }
    else 
    {
      print('notifications not loaded sa7');
    }
  }


  Future<void> turnOffNotification(String key) async {
    try {
      var data = await getData();
      setState(() {
        notificationsSettingsValues = data;
        notificationsSettingsValues[key] = !notificationsSettingsValues[key];
      });
      print("Updated notifics: $notificationsSettingsValues");
      var result = await updateData(
          updatedNotificationsSettings: notificationsSettingsValues);
      if (result != 200) {
        setState(() {
          notificationsSettingsValues[key] = !notificationsSettingsValues[key];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void onHide(String id, Notifications removedNotification) async {
    try {
      final status = await HideNotification(id: id);
      if (status == 200) {
        setState(() {
          earlierNotifications.removeWhere((n) => n.id == id);
          todayNotifications.removeWhere((n) => n.id == id);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
              itemCount:
                  todayNotifications.length + earlierNotifications.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  if (todayNotifications.isNotEmpty) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                } else if (index == todayNotifications.length + 1) {
                  if (earlierNotifications.isNotEmpty) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        "Earlier",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                } else if (index < todayNotifications.length + 1) {
                  final notification = todayNotifications[index - 1];
                  final data = processNotification(notification, context);
                  return NotificationWidget(
                    content: data.content!,
                    notification: notification,
                    date: dateToDuration(notification.createdAt),
                    iconData: data.icon,
                    buttonIcon: data.icon,
                    buttonText: data.buttonText,
                    onPressed: data.onPress,
                    isRead: widget.isAllRead || notification.isRead,
                    onHide: onHide,
                    community: community(notification.notificationType),
                    disable: turnOffNotification,
                  );
                } else {
                  final earlierIndex = index - todayNotifications.length - 2;
                  final notification = earlierNotifications[earlierIndex];
                  final data = processNotification(notification, context);
                  return NotificationWidget(
                    content: data.content!,
                    notification: notification,
                    date: dateToDuration(notification.createdAt),
                    iconData: data.icon,
                    buttonIcon: data.icon,
                    buttonText: data.buttonText,
                    onPressed: data.onPress,
                    isRead: widget.isAllRead || notification.isRead,
                    onHide: onHide,
                    community: community(notification.notificationType),
                    disable: turnOffNotification,
                  );
                }
              },
            ),
    );
  }
}

bool community(String notificationType) {
  bool isCommunity = notificationType == "community";
  print(" comminty $isCommunity");
  return isCommunity;
}