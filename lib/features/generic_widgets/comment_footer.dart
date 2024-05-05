import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';

/// A widget representing the footer section of a comment.
///
/// This widget displays interaction buttons and the comment score.
///
/// Example usage:
/// ```dart
/// CommentFooter(
///   onMorePressed: () {
///     // Handle "more" button pressed
///   },
///   onReplyPressed: () {
///     // Handle "reply" button pressed
///   },
///   number: 42,
///   upvoted: true,
///   downvoted: false,
/// )
/// ```
class CommentFooter extends StatelessWidget {
  /// Callback function triggered when the "more" button is pressed.
  final Function()? onMorePressed;

  /// Callback function triggered when the "reply" button is pressed.
  final Function()? onReplyPressed;

  /// The score (number of upvotes) for the comment.
  final int number;

  /// Whether the comment is upvoted by the current user.
  final bool upvoted;

  /// Whether the comment is downvoted by the current user.
  final bool downvoted;

  /// Creates a comment footer.
  ///
  /// The [onMorePressed], [onReplyPressed], and [number] parameters are required.
  /// The [upvoted] and [downvoted] parameters are optional and default to false.
  CommentFooter({
    required this.onMorePressed,
    required this.onReplyPressed,
    required this.number,
    this.upvoted = false,
    this.downvoted = false,
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
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_upward,
                  )),
              Text('$number'),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_downward,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
