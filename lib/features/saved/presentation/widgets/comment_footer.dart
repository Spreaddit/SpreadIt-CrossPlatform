import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';

class CommentFooter extends StatelessWidget {
  final Function()? onMorePressed;
  final Function()? onReplyPressed;
  final int number;
  final bool upvoted;
  final bool downvoted;

  CommentFooter({
    required this.onMorePressed,
    required this.onReplyPressed,
    required this.number,
    this.upvoted = false,
    this.downvoted = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      margin: EdgeInsets.only(left: screenWidth * 0.33),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onMorePressed,
                icon: Icon(Icons.more_vert),
              ),
              SizedBox(width: screenWidth * 0.02),
              IconButton(
                onPressed: onReplyPressed,
                icon: Icon(Icons.reply),
              ),
              Text('Reply'),
              SizedBox(width: screenWidth * 0.02),
              UpVoteButton(
                color: upvoted ? Colors.orange : Colors.grey,
                width: screenWidth * 0.04,
                height: screenWidth * 0.04,
              ),
              Text('$number'),
              DownVoteButton(
                color: downvoted ? Colors.purple : Colors.grey,
                width: screenWidth * 0.04,
                height: screenWidth * 0.04,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
