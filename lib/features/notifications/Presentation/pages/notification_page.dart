import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      notifications = await fetchNotifications();
      if (notifications.isEmpty) {
        recommendedCommunity = await getRecommendedCommunity();
        notifications.add(recommendedCommunity!);
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
        recommendedCommunity = await getRecommendedCommunity();
        notifications.add(recommendedCommunity!);
        print(notifications);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onHide(String id, Notifications removedNotification) async {
    try {
      final status = await HideNotification(id: id);
      if (status == 200) {
        setState(() {
          notifications.removeWhere((n) => n.id == id);
        });
      }
    } catch (e) {
      print(e);
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: isLoading
        ? LoaderWidget(
            dotSize: 10,
            logoSize: 100,
          )
        : ListView.builder(
            itemCount: todayNotifications.length + earlierNotifications.length + 2, // +2 for the headers
            itemBuilder: (context, index) {
              if (index == 0) {
                // Display header for today's notifications
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    "Today",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else if (index == todayNotifications.length + 1) {
                // Display header for earlier notifications
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    "Earlier",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else if (index < todayNotifications.length + 1) {
                // Display today's notifications
                final notification = todayNotifications[index - 1];
                final data = processNotification(notification, context);
                return NotificationWidget(
                  content: data.content!,
                  notification: notification,
                  date: dateToDuration(notification.createdAt),
                  iconData: data.icon,
                  buttonIcon: data.icon,
                  buttonText: data.buttonText ?? '',
                  onPressed: data.onPress,
                  isRead: notification.isRead,
                  followed: true,
                  onHide: onHide,
                  community: community(notification.notificationType),
                );
              } else {
                // Display earlier notifications
                final earlierIndex = index - todayNotifications.length - 2; // -2 to account for the headers
                final notification = earlierNotifications[earlierIndex];
                final data = processNotification(notification, context);
                return NotificationWidget(
                  content: data.content!,
                  notification: notification,
                  date: dateToDuration(notification.createdAt),
                  iconData: data.icon,
                  buttonIcon: data.icon,
                  buttonText: data.buttonText ?? '',
                  onPressed: data.onPress,
                  isRead: notification.isRead,
                  followed: true,
                  onHide: onHide,
                  community: community(notification.notificationType),
                );
              }
            },
          ),
  );
}
}

bool followed(String notificationType) {
  return notificationType == "posts" || notificationType == "comments";
}

bool community(String notificationType) {
  bool isCommunity = notificationType == "community";
  print(" comminty $isCommunity");
  return isCommunity;
}
