import 'package:flutter/material.dart';

Widget floatingNewChatButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.of(context).pushNamed('new-chat');
      print('Floating button pressed!');
    },
    child: Icon(Icons.chat_bubble),
  );
}
