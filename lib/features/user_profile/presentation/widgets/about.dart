
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/// The `AboutWidget` class is responsible for displaying user information such as post karma, comment karma, and about text.
///
/// This widget is typically used within user profile pages to provide a summary of the user's activity and background.
/// It also includes options for sending messages and starting chats, which are visible only on other users' profiles.

class AboutWidget extends StatelessWidget {
  /// The number of post karma points for the user.
  final String postKarmaNo;

  /// The number of comment karma points for the user.
  final String commentKarmaNo;

  /// The about text describing the user's profile.
  final String aboutText;

  /// Callback function triggered when the "Send a Message" button is pressed.
  final VoidCallback? onSendMessagePressed;

  /// Callback function triggered when the "Start Chat" button is pressed.
  final VoidCallback? onStartChatPressed;

  /// A boolean value indicating whether the current profile belongs to the logged-in user.
  final bool myProfile;

  /// Constructor for the `AboutWidget` class.
  ///
  /// Parameters:
  /// - `postKarmaNo`: The number of post karma points for the user.
  /// - `commentKarmaNo`: The number of comment karma points for the user.
  /// - `aboutText`: The about text describing the user's profile.
  /// - `onSendMessagePressed`: Callback function triggered when the "Send a Message" button is pressed.
  /// - `onStartChatPressed`: Callback function triggered when the "Start Chat" button is pressed.
  /// - `myProfile`: A boolean value indicating whether the current profile belongs to the logged-in user.
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
                      CupertinoIcons.envelope,
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
                      CupertinoIcons.chat_bubble_2_fill,
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
