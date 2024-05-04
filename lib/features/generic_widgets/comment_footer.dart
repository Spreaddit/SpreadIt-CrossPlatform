import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/vote_comment.dart';

class CommentFooter extends StatelessWidget {
  final Function()? onMorePressed;
  final Function()? onReplyPressed;
  final int number;
  final bool upvoted;
  final bool downvoted;
  final String? commentId;
  CommentFooter({
    required this.onMorePressed,
    required this.onReplyPressed,
    required this.number,
    this.upvoted = false,
    this.downvoted = false,
    this.commentId,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: kIsWeb ? screenHeight * 0.02 : screenWidth * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: onMorePressed,
                icon: Icon(Icons.more_vert),
              ),
              SizedBox(width: screenWidth * 0.01),
              TextButton(
                onPressed: onReplyPressed,
                child: Row(
                  children: [
                    Icon(Icons.reply, color: Colors.grey),
                    Text(
                      'Reply',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.01),
              /* IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_upward,
                  )),
              Text('$number'),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_downward,
                  )),*/
              CommentVoteButton(
                  initialVotesCount: number,
                  isUpvoted: upvoted,
                  isDownvoted: downvoted,
                  commentId: commentId!)
            ],
          ),
        ],
      ),
    );
  }
}
