import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/pages/chat_page.dart';

void navigateToChat(
    {required BuildContext context,
    required String docId,
    required String chatroomName}) {
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(
          name: '/chatroom/$docId/$chatroomName',
        ),
        builder: (context) => ChatPage(
          id: docId,
          chatroomName: chatroomName,
        ),
      ),
    );
  }
}
