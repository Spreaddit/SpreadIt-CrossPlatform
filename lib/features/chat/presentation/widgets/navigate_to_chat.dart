import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/pages/chat_page.dart';

void navigateToChat(BuildContext context, String docId) {
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: RouteSettings(
          name: '/chatroom/$docId',
        ),
        builder: (context) => ChatPage(
          id: docId,
        ),
      ),
    );
  }
}
