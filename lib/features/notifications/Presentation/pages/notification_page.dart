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
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final data = processNotification(notification, context);
                print(data);
                return NotificationWidget(
                  content: data.content!,
                  notification: notification,
                  date: dateToDuration(notification.createdAt),
                  iconData: data.icon,
                  buttonIcon: data.icon,
                  buttonText: data.buttonText??'',
                  onPressed: data.onPress,
                  isRead: notification.isRead,
                  followed: true,
                  onHide: onHide,
                  community: community(notification.notificationType),
                );
              },
            ),
    );
  }
}

bool followed(String notificationType) {
  return notificationType == "posts" || notificationType == "comments";
}

bool community(String notificationType) {
  bool isCommunity= notificationType == "community" ;
  print(" comminty $isCommunity");
  return isCommunity;
}
