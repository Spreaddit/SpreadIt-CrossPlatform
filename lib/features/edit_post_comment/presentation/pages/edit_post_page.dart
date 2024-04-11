import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/pages/edit_comment_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/comment_footer.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/add_comment.dart';

import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/on_more_functios.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_replies.dart';

class Media {
  final String type;
  final String link;

  Media({
    required this.type,
    required this.link,
  });
}

class _CommentHeader extends HookWidget {
  final String username;
  final String userId;
  final String postId;
  final DateTime date;
  final String profilePic;

  _CommentHeader({
    required this.username,
    required this.userId,
    required this.postId,
    required this.date,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context) {
    final sec30PassedToggler =
        useState(false); //used for changing time without constant re-render
    final dateFormatted = useState(dateToDuration(date));

    useEffect(() {
      dateFormatted.value = dateToDuration(date);
      print(dateFormatted.value);
      return;
    }, [sec30PassedToggler.value]);

    useEffect(() {
      final timer = Timer.periodic(Duration(seconds: 30), (timer) {
        sec30PassedToggler.value = !sec30PassedToggler.value;
      });

      return timer.cancel;
    }, []);

    return Material(
      color: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ListTile(
          contentPadding: EdgeInsets.only(top: 20),
          title: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                username,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(dateFormatted.value),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(profilePic),
          ),
        ),
      ),
    );
  }
}

class CommentCard extends StatefulWidget {
  final Comment comment;
  // bool collapseThreadFlag = false;

  CommentCard({required this.comment});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _repliesFetched = false;

  Future<void> fetchReplies() async {
    if (!_repliesFetched) {
      try {
        var data = await getCommentReplies(widget.comment.id);
        setState(() {
          widget.comment.replies = data;
          _repliesFetched = true;
        });
      } catch (e) {
        print('Error fetching comments: $e');
      }
    }
  }

  void addReply(Comment newReply) {
    setState(() {
      widget.comment.replies!.add(newReply);
      print('newComment${newReply.content}');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchReplies();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCommentWidget(widget.comment);
  }

  Widget _buildCommentWidget(Comment comment) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, top: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CommentHeader(
                      username: comment.username!,
                      userId: comment.userId!,
                      postId: comment.postId!,
                      date: comment.createdAt,
                      profilePic: comment.profilePic!,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          comment.isCollapsed = !comment.isCollapsed!;
                        });
                      },
                      child: Text(
                        comment.content,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    CommentFooter(
                      onMorePressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomBottomSheet(
                              icons: [
                                Icons.share,
                                Icons.notifications_on_rounded,
                                Icons.save,
                                Icons.copy,
                                Icons.block,
                                Icons.flag
                              ],
                              text: [
                                "Share",
                                "Get Reply notifications",
                                "Save",
                                "Copy text",
                                "Block account",
                                "Report"
                              ],
                              onPressedList: [
                                () {
                                  sharePressed(comment.content);
                                },
                                getReplyNotifications,
                                save,
                                copyText,
                                blockAccount,
                                report
                              ],
                            );
                          },
                        );
                      },
                      onReplyPressed: () {
                        /* AddReplyWidget(
                            parentCommentId: comment.id, addReply: addReply);
                        print("ghhh");*/

                        Navigator.of(context).pushNamed(
                          '/edit_comment',
                          arguments: {
                            'comment': comment,
                          },
                        );
                      },
                      number: comment.likesCount,
                      upvoted: false,
                      downvoted: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!comment.isCollapsed &&
              comment.replies != null) // && !widget.collapseThreadFlag)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: comment.replies!.map((reply) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recursively build nested replies
                    Container(
                      child: CommentCard(comment: reply),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 8.0),
                    ),
                  ],
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
