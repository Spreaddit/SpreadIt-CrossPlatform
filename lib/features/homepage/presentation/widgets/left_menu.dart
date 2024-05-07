import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/dynamic_navigations/navigate_to_community.dart';
import 'package:spreadit_crossplatform/user_info.dart';

class LeftMenu extends StatelessWidget {
  List<String?> subscribedCommunities = UserSingleton().user!.subscribedCommunities!;
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ...[
            {
              'icon': Icons.groups,
              'text': 'Your Communities',
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
          
          ListTile(
            title: Text(
              'Communities',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
        ...subscribedCommunities.map((community) {
            return ListTile(
              title: Text('r/${community??''}'),
             onTap: () {navigateToCommunity(context, community!);},
            );
          }).toList(),
        ],
      ),
    );
  }
}
