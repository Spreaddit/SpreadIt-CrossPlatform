import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/data/data_source/api_notifications_settings.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/get_notifications.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/get_recommended_community.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/hide_notifications.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/get_according_to_type.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/notification_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Notifications> todayNotifications = [];
  List<Notifications> earlierNotifications = [];
  List<Notifications> notifications = [];
  bool isLoading = true;
  Notifications? recommendedCommunity;

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
    fetchData();
  }

  Future<void> getSuggestedCommunity() async {
    recommendedCommunity = await getRecommendedCommunity();
    DateTime now = DateTime.now();
    DateTime date = recommendedCommunity!.createdAt;
    bool isToday = (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day);
    setState(() {
      if (isToday) {
        todayNotifications.add(recommendedCommunity!);
      } else {
        earlierNotifications.add(recommendedCommunity!);
      }
    });
  }

  Future<void> fetchData() async {
    try {
      notifications = await fetchNotifications();
      if (notifications.isEmpty) {
        await getSuggestedCommunity();
      } else {
        final today = DateTime.now().toLocal();
        setState(() {
          todayNotifications = notifications.where((n) {
            final notificationDate = n.createdAt.toLocal();
            return notificationDate.year == today.year &&
                notificationDate.month == today.month &&
                notificationDate.day == today.day;
          }).toList();

          earlierNotifications = notifications.where((n) {
            final notificationDate = n.createdAt.toLocal();
            return !todayNotifications.contains(n) &&
                notificationDate.isBefore(today);
          }).toList();
        });
      }
    } catch (e) {
      print(e);
      if (notifications.isEmpty) {
        await getSuggestedCommunity();
      }
    } finally {
      setState(() {
        isLoading = false;
      });
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
      body: isLoading
          ? LoaderWidget(
              dotSize: 10,
              logoSize: 100,
            )
          : ListView.builder(
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
                    isRead: notification.isRead,
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
                    isRead: notification.isRead,
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
