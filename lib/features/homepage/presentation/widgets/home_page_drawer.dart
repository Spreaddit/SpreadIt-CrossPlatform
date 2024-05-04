import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/user_info.dart';

class HomePageDrawer extends StatelessWidget {
  bool isAdmin = UserSingleton().user?.role == 'Admin';
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              'u/${UserSingleton().user?.username ?? 'user'}',
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          ...[
            {
              'icon': Icons.account_circle_outlined,
              'text': 'My profile',
              'route': '/user-profile'
            },
            {
              'icon': Icons.group,
              'text': 'Create a community',
              'route': '/create_a_community'
            },
            {
              'icon': Icons.bookmarks_outlined,
              'text': 'Saved',
              'route': '/saved'
            },
            {
              'icon': Icons.watch_later_outlined,
              'text': 'History',
              'route': '/history'
            },
            {
              'icon': Icons.settings_outlined,
              'text': 'Settings',
              'route': '/settings'
            },
            if (isAdmin)
              {
                'icon': Icons.admin_panel_settings_outlined,
                'text': 'View Reports',
                'route': '/admin-view'
              },
            // Logout Button
            {
              'icon': Icons.logout,
              'text': 'Log out',
              'route': '/logout',
            }
          ].map((Map<String, dynamic> item) {
            return ListTile(
              leading: Icon(item['icon']),
              title: Text(item['text'], style: TextStyle(fontSize: 18.0)),
              onTap: () {
                if (item['route'] == '/logout') {
                  UserSingleton().clearUserFromPrefs();
                  UserSingleton().user = null; // Clear user info
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/start-up-page', (route) => false);
                } else {
                  Navigator.pushNamed(context, item['route']);
                }
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
