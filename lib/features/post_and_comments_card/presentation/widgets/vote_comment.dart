import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/downvote.dart';
import 'package:spreadit_crossplatform/features/homepage/data/upvote.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/downvote_comment.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/upvote_comment.dart';

/// This widget is responsible for the display
/// of [VoteCount]
class CommentVoteButton extends StatefulWidget {
  final int initialVotesCount;
  bool isUpvoted;
  bool isDownvoted;
  bool isRemoved;
  bool isRemoval;
  final String commentId;

  CommentVoteButton({
    required this.initialVotesCount,
    required this.isUpvoted,
    required this.isDownvoted,
    required this.commentId,
    this.isRemoval = false,
    this.isRemoved = false,
  });

  State<CommentVoteButton> createState() => _CommentVoteButtonState();
}

class _CommentVoteButtonState extends State<CommentVoteButton> {
  late Color upvoteButtonColor = Colors.grey;
  late Color downvoteButtonColor = Colors.grey;
  late int votesCount;

  @override
  void initState() {
    super.initState();
    // Initialize vote count and button colors based on initial state
    setState(() {
      print("initi: ${widget.initialVotesCount}");
      votesCount = widget.initialVotesCount;
      if (widget.isUpvoted) {
        upvoteButtonColor = Colors.orange;
      } else if (widget.isDownvoted) {
        downvoteButtonColor = Colors.purple;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          if (widget.isRemoved || widget.isRemoval)
            IconButton(
              onPressed: () {
                widget.isRemoval
                    ? CustomSnackbar(content: "This is the removal reason!")
                        .show(context)
                    : CustomSnackbar(
                            content: "This comment has been removed as spam!")
                        .show(context);
              },
              icon: Icon(
                Icons.arrow_upward,
                color: upvoteButtonColor,
              ),
            )
          else
            IconButton(
              onPressed: () {
                setState(() {
                  if (widget.isUpvoted) {
                    // If already upvoted, cancel the upvote
                    upvoteButtonColor = Colors.grey;
                    votesCount--;
                    widget.isUpvoted = !widget.isUpvoted;
                  } else if (!widget.isDownvoted && !widget.isUpvoted) {
                    // If not upvoted, upvote
                    upvoteButtonColor = Colors.orange;
                    votesCount++;
                    widget.isUpvoted = !widget.isUpvoted;
                  }
                  // If previously downvoted, cancel the downvote
                  if (widget.isDownvoted) {
                    downvoteButtonColor = Colors.grey;
                    upvoteButtonColor = Colors.orange;
                    votesCount += 2;
                    widget.isUpvoted = !widget.isUpvoted;
                    widget.isDownvoted = !widget.isDownvoted;
                  }

                  print("before upvote api: ${widget.isUpvoted}");
                  upvoteComment(commentId: widget.commentId);
                  print("after upvote api: ${widget.isUpvoted}");
                });
              },
              icon: Icon(
                Icons.arrow_upward,
                color: upvoteButtonColor,
              ),
            ),
          Text(
            votesCount.toString(),
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          if (widget.isRemoved || widget.isRemoval)
            IconButton(
              onPressed: () {
                widget.isRemoval
                    ? CustomSnackbar(content: "This is the removal reason!")
                        .show(context)
                    : CustomSnackbar(
                            content: "This comment has been removed as spam!")
                        .show(context);
              },
              icon: Icon(
                Icons.arrow_downward,
                color: downvoteButtonColor,
              ),
            )
          else
            IconButton(
              onPressed: () {
                setState(() {
                  // If already downvoted, cancel the downvote
                  if (widget.isDownvoted) {
                    downvoteButtonColor = Colors.grey;
                    votesCount++;
                    widget.isDownvoted = !widget.isDownvoted;
                  } // If not downvoted, downvote
                  else if (!widget.isDownvoted && !widget.isUpvoted) {
                    downvoteButtonColor = Colors.purple;
                    votesCount--;
                    widget.isDownvoted = !widget.isDownvoted;
                  }
                  // If previously upvoted, cancel the upvote
                  else if (widget.isUpvoted) {
                    upvoteButtonColor = Colors.grey;
                    downvoteButtonColor = Colors.purple;
                    votesCount -= 2;
                    widget.isDownvoted = !widget.isDownvoted;
                    widget.isUpvoted = !widget.isUpvoted;
                  }

                  print("before dowvote api: ${widget.isDownvoted}");
                  downvoteComment(commentId: widget.commentId);
                  print("after dowvote api: ${widget.isDownvoted}");
                });
              },
              icon: Icon(
                Icons.arrow_downward,
                color: downvoteButtonColor,
              ),
            )
        ],
      ),
    );
  }
}
