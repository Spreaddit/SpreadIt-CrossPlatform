import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';

//data//
//, 'icon': '
List blockedUsers = [
  {
    'name': 'rehab',
    'icon': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
  },
  {
    'name': 'mimo',
    'icon': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'
  },
  {
    'name': 'fofa',
    'icon': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'
  }
];

class BlockedAccountsPage extends StatefulWidget {
  const BlockedAccountsPage({Key? key}) : super(key: key);
  @override
  State<BlockedAccountsPage> createState() {
    return _BlockedAccountsPageState();
  }
}

class _BlockedAccountsPageState extends State<BlockedAccountsPage> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Blocked Accouts',
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
          shrinkWrap: true,
          children: blockedUsers.map((e) {
            return ListTile(
              leading: CircleAvatar(foregroundImage: NetworkImage(e['icon'])),
              title: Text(e['name'],
                  style: TextStyle(fontSize: 18, color: Colors.black)),
              trailing: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      blockedUsers.remove(e);
                    });
                  },
                  child: Text('Unblock')),
            );
          }).toList()),
    );
  }
}
