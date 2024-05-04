import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
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
  bool noNotifications = false;
  Community? recommendedCommunity;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      notifications = await fetchNotifications();
      recommendedCommunity = await getRecommendedCommunity();
    } catch (e) {
      print(e);
      noNotifications = true;
      recommendedCommunity = await getRecommendedCommunity();
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
      appBar: AppBar(
        title: Text('Dummy Notifications'),
      ),
      body: isLoading
          ? LoaderWidget(
              dotSize: 10,
              logoSize: 100,
            )
          : notifications.isEmpty || noNotifications
              ? Center(
                child: Text("No notifications"),
              )
              : ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    final data = processNotification(notification);
                    return NotificationWidget(
                      content: data.content,
                      notification: notification,
                      date: dateToDuration(notification.createdAt),
                      iconData: data.icon,
                      buttonIcon: data.icon,
                      buttonText: data.buttonText,
                      onPressed: data.onPress,
                      isRead: notification.isRead,
                      followed: followed(notification.notificationType),
                      onHide: onHide,
                    );
                  },
                ),
    );
  }
}

bool followed(String notificationType) {
  return notificationType == "posts" || notificationType == "comments";
}
