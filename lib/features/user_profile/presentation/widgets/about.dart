
import 'package:flutter/material.dart';

class AboutWidget extends StatelessWidget {
  final String postKarmaNo;
  final String commentKarmaNo;
  final String aboutText;
  final VoidCallback? onSendMessagePressed;
  final VoidCallback? onStartChatPressed;
  final bool myProfile;

  AboutWidget({
    required this.commentKarmaNo,
    required this.aboutText,
    required this.postKarmaNo,
    required this.myProfile,
    this.onSendMessagePressed,
    this.onStartChatPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postKarmaNo,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Post Karma",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(width: screenWidth * 0.3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commentKarmaNo,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Comment Karma",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            aboutText,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: screenHeight * 0.03),
          if (!myProfile)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (onSendMessagePressed != null)
                  TextButton.icon(
                    onPressed: onSendMessagePressed,
                    icon: Icon(
                      Icons.message_outlined,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Send a Message",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                SizedBox(height: screenHeight * 0.03),
                if (onStartChatPressed != null)
                  TextButton.icon(
                    onPressed: onStartChatPressed,
                    icon: Icon(
                      Icons.chat_bubble_outline_outlined,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Start Chat",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
