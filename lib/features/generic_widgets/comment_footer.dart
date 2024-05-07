import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/lock_a_comment.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/remove_a_comment.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/unlock_a_comment.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/vote_comment.dart';

class CommentFooter extends StatefulWidget {
  final Function()? onMorePressed;
  final Function()? onReplyPressed;
  final void Function(bool)? onLock;
  final void Function(bool)? onRemove;
  final int number;
  final bool upvoted;
  final bool downvoted;
  final String? commentId;
  final bool isPostLocked;
  bool isCommentLocked;
  bool isRemoved;
  bool isRemoval;
  final bool isModeratorView;
  final bool canManageComment;
  String? communityName;
  CommentFooter({
    required this.onMorePressed,
    required this.onReplyPressed,
    required this.number,
    this.upvoted = false,
    this.downvoted = false,
    this.isPostLocked = false,
    this.isCommentLocked = false,
    this.isRemoved = false,
    this.isRemoval = false,
    this.commentId,
    this.isModeratorView = false,
    this.canManageComment = false,
    this.onLock,
    this.onRemove,
    this.communityName,
  });
  @override
  State<CommentFooter> createState() => CommentFooterState();
}

class CommentFooterState extends State<CommentFooter> {
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
              if (!widget.isRemoval && !widget.isRemoved)
                IconButton(
                  onPressed: widget.onMorePressed,
                  icon: Icon(Icons.more_vert),
                )
              else
                IconButton(
                    onPressed: () {
                      widget.isRemoval
                          ? CustomSnackbar(
                                  content: "This is the removal reason!")
                              .show(context)
                          : CustomSnackbar(
                                  content:
                                      "This comment has been removed as spam!")
                              .show(context);
                    },
                    icon: Icon(Icons.more_vert, color: Colors.grey)),
              SizedBox(width: screenWidth * 0.01),
              if (!widget.isCommentLocked && !widget.isPostLocked ||
                  widget.isModeratorView && widget.canManageComment)

                //(widget.isModeratorView &&
                //   (!widget.isRemoved || !widget.isRemoval)))
                if (!widget.isRemoved && !widget.isRemoval)
                  TextButton(
                    onPressed: widget.onReplyPressed,
                    child: Row(
                      children: [
                        Icon(Icons.reply, color: Colors.grey),
                        Text(
                          'Reply',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  )
                else
                  TextButton(
                    onPressed: () {
                      widget.isRemoval
                          ? CustomSnackbar(
                                  content: "This is the removal reason!")
                              .show(context)
                          : CustomSnackbar(
                                  content:
                                      "This comment has been removed as spam!")
                              .show(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.reply,
                            color: Color.fromARGB(255, 255, 254, 254)),
                        Text(
                          'Reply',
                          style: TextStyle(
                              color: const Color.fromARGB(137, 219, 212, 212)),
                        ),
                      ],
                    ),
                  )
              else
                TextButton(
                  onPressed: () {
                    CustomSnackbar(content: "Locked :(").show(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.reply,
                          color: Color.fromARGB(255, 255, 254, 254)),
                      Text(
                        'Reply',
                        style: TextStyle(
                            color: const Color.fromARGB(137, 219, 212, 212)),
                      ),
                    ],
                  ),
                ),
              SizedBox(width: screenWidth * 0.01),
              CommentVoteButton(
                  isRemoved: widget.isRemoved,
                  isRemoval: widget.isRemoval,
                  initialVotesCount: widget.number,
                  isUpvoted: widget.upvoted,
                  isDownvoted: widget.downvoted,
                  commentId: widget.commentId!),
              // SizedBox(width: screenWidth * 0.01),
              if (widget.isModeratorView &&
                  !widget.isRemoved &&
                  !widget.isRemoval)
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomBottomSheet(
                          icons: [
                            Icons.lock,
                            Icons.delete,
                          ],
                          text: [
                            widget.isCommentLocked
                                ? "unlock thread"
                                : "Lock thread",
                            "Remove as spam",
                          ],
                          onPressedList: [
                            () {
                              //Lock comments
                              setState(() {
                                print(widget.commentId!);
                                widget.isCommentLocked
                                    ? unlockComment(
                                        commentId: widget.commentId!,
                                        communityName: widget.communityName!)
                                    : lockComment(
                                        commentId: widget.commentId!,
                                        communityName: widget.communityName!);
                                widget.isCommentLocked =
                                    !widget.isCommentLocked;
                                widget.onLock!(widget.isCommentLocked);
                                Navigator.pop(context);
                                widget.isCommentLocked
                                    ? CustomSnackbar(
                                            content:
                                                "Thread has been locked successfully!")
                                        .show(context)
                                    : CustomSnackbar(
                                            content:
                                                "Thread has been unlocked successfully!")
                                        .show(context);
                              });
                            },
                            () {
                              setState(() {
                                removeCommentAsSpam(
                                    communityName: widget.communityName!,
                                    commentId: widget.commentId!);
                                widget.onRemove!(true);
                                Navigator.pop(context);
                                CustomSnackbar(
                                        content:
                                            "Comment will be removed as spam!")
                                    .show(context);
                              });
                            },
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.shield,
                  ),
                )
              else if (widget.isModeratorView)
                IconButton(
                  onPressed: () {
                    widget.isRemoval
                        ? CustomSnackbar(content: "This is the removal reason!")
                            .show(context)
                        : CustomSnackbar(
                                content:
                                    "This comment has been removed as spam!")
                            .show(context);
                  },
                  icon: Icon(
                    Icons.shield,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
