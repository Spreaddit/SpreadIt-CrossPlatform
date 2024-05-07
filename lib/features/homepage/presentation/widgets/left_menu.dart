import 'package:flutter/material.dart';

// TODO:COMPLETE MENU

class LeftMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ...[
            {
              'icon': Icons.groups,
              'text': 'Your Communties',
              'route': '/discover',
            },
            {
              'icon': Icons.select_all,
              'text': 'All',
              'route': '/all',
            }
          ].map((Map<String, dynamic> item) {
            return ListTile(
              leading: Icon(item['icon']),
              title: Text(item['text'], style: TextStyle(fontSize: 18.0)),
              onTap: () {
                Navigator.of(context).pushNamed(item['route']);
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
