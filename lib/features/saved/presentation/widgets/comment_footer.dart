import 'package:flutter/material.dart';

class CommentFooter extends StatelessWidget {
  final Function()? onMorePressed;
  final Function()? onReplyPressed;
  final Function()? onUpvotePressed;
  final Function()? onDownvotePressed;
  final int number;
  final bool upvoted;
  final bool downvoted;

  CommentFooter({
    required this.onMorePressed,
    required this.onReplyPressed,
    required this.onUpvotePressed,
    required this.onDownvotePressed,
    required this.number,
    this.upvoted = false,
    this.downvoted = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      margin: EdgeInsets.only(left: screenWidth * 0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onMorePressed,
                icon: Icon(Icons.more_vert),
              ),
              SizedBox(width: 8.0),
              IconButton(
                onPressed: onReplyPressed,
                icon: Icon(Icons.reply),
              ),
              SizedBox(width: 8.0),
              Text('Reply'),
              SizedBox(width: 8.0),
              GestureDetector(
                onTap: onUpvotePressed,
                child: ImageIcon(
                  AssetImage("assets/images/upvoteicon.png"),
                  size: screenHeight * 0.02,
                  color: upvoted ? Colors.orange : Colors.grey,
                ),
              ),
              SizedBox(width: 8.0),
              Text('$number'),
              SizedBox(width: 8.0),
              GestureDetector(
                onTap: onDownvotePressed,
                child: ImageIcon(
                  AssetImage("assets/images/downvoteicon.png"),
                  size: screenHeight * 0.02,
                  color: downvoted ? Colors.purple : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
