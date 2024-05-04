import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/homepage/data/downvote.dart';
import 'package:spreadit_crossplatform/features/homepage/data/upvote.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';

/// This widget is responsible for the display
/// of [VoteCount]
/// and the total vote count (upvotes - down votes)
class VoteButton extends StatefulWidget {
  final int initialVotesCount;
  bool isUpvoted;
  bool isDownvoted;
  final String postId;

  VoteButton({
    required this.initialVotesCount,
    required this.isUpvoted,
    required this.isDownvoted,
    required this.postId,
  });

  State<VoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {
  late Color upvoteButtonColor = Colors.grey;
  late Color downvoteButtonColor = Colors.grey;
  late int votesCount;
  var votes;

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

  Future<void> upVote() async {
    {
      try {
        votes = await upvote(postId: widget.postId);

        setState(() {});
      } catch (e) {
        print('Error fetching comments: $e');
      }
    }
  }

  Future<void> downVote() async {
    {
      try {
        votes = await downvote(postId: widget.postId);

        setState(() {});
      } catch (e) {
        print('Error fetching comments: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (widget.isUpvoted) {
                  // If already upvoted, cancel the upvote
                  upvoteButtonColor = Colors.grey;
                  votesCount--;
                  //upVote();
                  //votesCount = votes;
                  widget.isUpvoted = !widget.isUpvoted;
                } else if (!widget.isDownvoted && !widget.isUpvoted) {
                  // If not upvoted, upvote
                  upvoteButtonColor = Colors.orange;
                  votesCount++;
                  //upVote();
                  //votesCount = votes;
                  widget.isUpvoted = !widget.isUpvoted;
                }
                // If previously downvoted, cancel the downvote
                if (widget.isDownvoted) {
                  downvoteButtonColor = Colors.grey;
                  upvoteButtonColor = Colors.orange;
                  votesCount += 2;
                  // upVote();
                  // votesCount = votes;
                  widget.isUpvoted = !widget.isUpvoted;
                  widget.isDownvoted = !widget.isDownvoted;
                }

                print("before upvote api: ${widget.isUpvoted}");
                upvote(postId: widget.postId);
                print("after upvote api: ${widget.isUpvoted}");
              });
              // Call upvote API
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
          IconButton(
            onPressed: () {
              setState(() {
                // If already downvoted, cancel the downvote
                if (widget.isDownvoted) {
                  downvoteButtonColor = Colors.grey;
                  votesCount++;
                  //downVote();
                  // votesCount = votes;
                  widget.isDownvoted = !widget.isDownvoted;
                } // If not downvoted, downvote
                else if (!widget.isDownvoted && !widget.isUpvoted) {
                  downvoteButtonColor = Colors.purple;
                  votesCount--;
                  // downVote();
                  // votesCount = votes;
                  widget.isDownvoted = !widget.isDownvoted;
                }
                // If previously upvoted, cancel the upvote
                else if (widget.isUpvoted) {
                  upvoteButtonColor = Colors.grey;
                  downvoteButtonColor = Colors.purple;
                  votesCount -= 2;
                  //downVote();
                  // votesCount = votes;
                  widget.isDownvoted = !widget.isDownvoted;
                  widget.isUpvoted = !widget.isUpvoted;
                }

                print("before dowvote api: ${widget.isDownvoted}");
                downvote(postId: widget.postId);
                print("after dowvote api: ${widget.isDownvoted}");
              });
            },
            icon: Icon(
              Icons.arrow_downward,
              color: downvoteButtonColor,
            ),
          ),
        ],
      ),
    );
  }
}
