import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';

/// This widget is responsible for the display
/// of [VoteCount]
/// and the total vote count (upvotes - down votes)
class VoteButton extends StatefulWidget {
  final int initialVotesCount; // TODO: to be changed to a state
  final bool isUpvoted;
  final bool isDownvoted;

  VoteButton({
    required this.initialVotesCount,
    required this.isUpvoted,
    required this.isDownvoted,
  });

  //TODO: implement votes' count logic
  State<VoteButton> createState() => _VoteButtonState();
}

class _VoteButtonState extends State<VoteButton> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_upward,
              )),
          Text(
            widget.initialVotesCount
                .toString(), //TODO: Replace with real vote count (upvotes - down votes)
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_downward,
              )),
        ],
      ),
    );
  }
}
