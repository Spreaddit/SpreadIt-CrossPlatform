import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';

class ManageNotificationBottomSheet extends StatelessWidget {
  final bool followed;
  final bool community;

  ManageNotificationBottomSheet({
    required this.followed,
    required this.community,
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
            if (!followed && !community)
              ListTile(
                leading: Icon(Icons.notifications_off, color: Colors.black),
                title: Text("Don't get updates on this"),
                onTap: () {
                  // Add your logic here for handling this action
                },
              ),
            if (followed || community)
              ListTile(
                leading: Icon(Icons.visibility_off, color: Colors.black),
                title: Text("Hide this notification"),
                onTap: () {
                  // Add your logic here for handling this action
                },
              ),
            if (followed || community)
              ListTile(
                leading: Icon(Icons.notifications_off, color: Colors.black),
                title: Text("Turn off this notification type"),
                onTap: () {
                  // Add your logic here for handling this action
                },
              ),
            if (community)
              ListTile(
                leading: Icon(Icons.do_not_disturb_on, color: Colors.black),
                title: Text("Disable updates from this community"),
                onTap: () {
                  // Add your logic here for handling this action
                },
              ),
            Button(
              onPressed: () {
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
