import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/disable_community_notification.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/get_according_to_type.dart';

class ManageNotificationBottomSheet extends StatelessWidget {
  final Function(String) disable;
  final bool community;
  final void Function(String, Notifications) onHide;
  final Notifications notification;
  final VoidCallback markMessageAsRead;

  ManageNotificationBottomSheet({
    required this.disable,
    required this.community,
    required this.onHide,
    required this.notification,
    required this.markMessageAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                "Manage Notifications",
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(),
            if (notification.notificationType == "Comment Reply" ||
                notification.notificationType == "Comment")
              ListTile(
                leading: Icon(Icons.notifications_off, color: Colors.black),
                title: Text("Don't get updates on this"),
                onTap: () {
                  markMessageAsRead();
                  String key = getNotificationType(notification);
                  disable(key);
                  Navigator.pop(context);
                },
              ),
            if (notification.notificationType != "Comment Reply" &&
                notification.notificationType != "Comment" &&
                !community)
              ListTile(
                leading: Icon(Icons.visibility_off, color: Colors.black),
                title: Text("Hide this notification"),
                onTap: () {
                  onHide(notification.id!, notification);
                  Navigator.pop(context);
                },
              ),
            if (notification.notificationType != "Comment Reply" &&
                notification.notificationType != "Comment" &&
                !community)
              ListTile(
                leading: Icon(Icons.notifications_off, color: Colors.black),
                title: Text("Turn off this notification type"),
                onTap: () {
                  markMessageAsRead();
                  String key = getNotificationType(notification);
                  disable(key);
                  Navigator.pop(context);
                },
              ),
            if (community)
              ListTile(
                leading: Icon(Icons.do_not_disturb_on, color: Colors.black),
                title: Text("Disable updates from this community"),
                onTap: () async {
                  markMessageAsRead();
                  await disableCommunitynotifications(id: notification.id!);
                  Navigator.pop(context);
                },
              ),
            Button(
              onPressed: () {
                markMessageAsRead();
                Navigator.pop(context);
              },
              text: 'Close',
              backgroundColor: Color(0xFFEFEFED),
              foregroundColor: Color.fromARGB(255, 113, 112, 112),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
