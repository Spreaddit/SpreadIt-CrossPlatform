import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';

/// This Library is responsible for handling post interactions
/// (e.g., votes, comments and shares)

/// This widget is responsible for the display
/// and state handling of an upvote button
/// in a [PostWidget] card
class UpVoteButton extends HookWidget {
  Color color;
  double width;
  double height;
  UpVoteButton({
    this.color = const Color.fromARGB(255, 255, 68, 0),
    this.width = 18,
    this.height = 24,
  });
  void upVote() {
    print("upvoted");
    //TODO: impement upvote logic (you can change icon button to match needed logic)
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: IconButton(
        onPressed: upVote,
        icon: Icon(
          Icons.arrow_upward,
          size: 24.0,
          color: Color.fromARGB(255, 255, 68, 0),
        ),
      ),
    );
  }
}

/// This widget is responsible for the display
/// and state handling of a downvote button
/// in a [PostWidget] card
class DownVoteButton extends HookWidget {
  Color color;
  double width;
  double height;
  DownVoteButton({
    this.color = const Color.fromARGB(255, 255, 68, 0),
    this.width = 18,
    this.height = 24,
  });
  void downVote() {
    print("downvotes");
    //TODO: impement downvote logic (you can change icon button to match needed logic)
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: downVote,
      icon: Icon(
        Icons.arrow_downward,
        size: 24.0,
      ),
    );
  }
}

/// This widget is responsible for the display
/// of [UpVoteButton] and [DownVoteButton]
/// and the total vote count (upvotes - down votes)
class VoteButton extends HookWidget {
  int initialVotesCount; // TODO: to be changed to a state
  VoteButton({
    required this.initialVotesCount,
  });

  //TODO: implement votes' count logic

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 40,
      child: Row(
        children: [
          UpVoteButton(),
          Text(
            initialVotesCount
                .toString(), //TODO: Replace with real vote count (upvotes - down votes)
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          DownVoteButton(),
        ],
      ),
    );
  }
}

/// This widget is responsible for the display
/// and state handling of a share button/share count
/// in a [PostWidget] card
class ShareButton extends HookWidget {
  int initialSharesCount;
  String message; // TODO: to be changed to a state
  ShareButton({required this.initialSharesCount, required this.message});

  void onShareClick() {
    sharePressed(message);
    print("share");
    //TODO: impement share logic
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onShareClick,
      style: ElevatedButton.styleFrom(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      child: SizedBox(
        height: 30,
        width: 60,
        child: Center(
          child: Wrap(
            children: [
              Icon(Icons.share), //TODO: Replace with real share count
              SizedBox(width: 5),
              Text(initialSharesCount.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

/// This widget is responsible for the display
/// and state handling of a comment button/comment count
/// in a [PostWidget] card
class CommentButton extends HookWidget {
  int initialCommensCount; // TODO: to be changed to a state
  CommentButton({
    required this.initialCommensCount,
  });

  void onCommentClick() {
    print("share");
    //TODO: impement share logic
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onCommentClick,
      style: ElevatedButton.styleFrom(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      child: SizedBox(
        height: 30,
        width: 80,
        child: Center(
          child: Wrap(
            children: [
              Icon(Icons.comment), //TODO: Replace with real share count
              SizedBox(width: 5),
              Text(initialCommensCount.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
