import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/pages/edit_comment_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/comment_footer.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/update_comments_list.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/on_more_functios.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_replies.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';

/// Represents a media object.
class Media {
  /// Type of the media.
  final String type;

  /// Link to the media.
  final String link;

  /// Constructs a [Media] object with the specified [type] and [link].
  Media({
    required this.type,
    required this.link,
  });
}

/// Represents the header of a comment widget.
class _CommentHeader extends HookWidget {
  final String username;
  final String userId;
  final String postId;
  final DateTime date;
  final String profilePic;

  /// Constructs a [_CommentHeader] widget with the given parameters.
  _CommentHeader({
    required this.username,
    required this.userId,
    required this.postId,
    required this.date,
    required this.profilePic,
  });

  @override
  Widget build(BuildContext context) {
    final sec30PassedToggler = useState(false);
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

/// Represents a comment widget.
class CommentCard extends StatefulWidget {
  final Comment comment;
  final String community;
  final VoidCallback? setIsLoaded;
  final bool onecomment;
  // bool collapseThreadFlag = false;

  /// Constructs a [CommentCard] widget with the given parameters.
  CommentCard({
    required this.comment,
    required this.community,
    this.setIsLoaded,
    this.onecomment=false,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _repliesFetched = false;
  late bool isUserProfile;
  bool isNotApprovedForEditOrReply = false;
  var issaved;
  File? uploadedImageFile;
  Uint8List? uploadedImageWeb;

  /// Fetches replies for the comment asynchronously.
  Future<void> fetchReplies() async {
    if (!_repliesFetched) {
      try {
        var data = await getCommentReplies(widget.comment.id);
        setState(() {
          widget.comment.replies = data;
          _repliesFetched = true;
          if(widget.onecomment)
          {
            widget.setIsLoaded!();
          }
        });
      } catch (e) {
        print('Error fetching comments: $e');
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isUserProfile = UserSingleton().user != null &&
        widget.comment.username == UserSingleton().user!.username;
    fetchReplies();
  }

  @override
  void initState() {
    super.initState();
    issaved = widget.comment.isSaved!;
    checkIfCanEditOrReply();
  }

  /// [checkIfCanEditOrReply] : a function used to check if users aren't approved for editing comments in the community

  void checkIfCanEditOrReply() async {
    await checkIfNotApproved(widget.community, UserSingleton().user!.username)
        .then((value) {
      isNotApprovedForEditOrReply = value;
    });
    setState(() {
      //TODO: check if this causes exception
      isNotApprovedForEditOrReply = isNotApprovedForEditOrReply;
    });
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
                    if (comment.media != null && comment.media!.isNotEmpty)
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(comment.media![0].link),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    CommentFooter(
                      commentId: widget.comment.id,
                      onMorePressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomBottomSheet(
                              icons: [
                                Icons.share,
                                Icons.notifications_on_rounded,
                                Icons.save,
                                if (isUserProfile &&
                                    !isNotApprovedForEditOrReply)
                                  Icons.edit,
                                Icons.copy,
                                if (!isUserProfile) Icons.block,
                                if (!isUserProfile) Icons.flag
                              ],
                              text: [
                                "Share",
                                "Get Reply notifications",
                                issaved ? "Unsave" : "save",
                                if (isUserProfile &&
                                    !isNotApprovedForEditOrReply)
                                  "Edit Comment",
                                "Copy text",
                                if (!isUserProfile) "Block account",
                                if (!isUserProfile) "Report"
                              ],
                              onPressedList: [
                                () {
                                  sharePressed(comment.content);
                                },
                                getReplyNotifications,
                                () => {
                                      saveOrUnsaveComment(
                                        context,
                                        comment.id,
                                      ),
                                      setState(() {
                                        issaved = !issaved;
                                      })
                                    },
                                if (isUserProfile &&
                                    !isNotApprovedForEditOrReply)
                                  () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditComment(
                                            comment: widget.comment,
                                          ),
                                        ),
                                      ),
                                () => copyText(
                                      context,
                                      widget.comment.content,
                                    ),
                                if (!isUserProfile)
                                  () => blockAccount(
                                        widget.comment.username!,
                                      ),
                                if (!isUserProfile)
                                  () => report(
                                        context,
                                        widget.community,
                                        widget.comment.postId!,
                                        widget.comment.id,
                                        widget.comment.username!,
                                        false,
                                      ),
                              ],
                            );
                          },
                        );
                      },
                      onReplyPressed: () {
                        if (isNotApprovedForEditOrReply) {
                          CustomSnackbar(
                                  content:
                                      "You are not approved to reply in this community")
                              .show(context);
                          return;
                        }
                        TextEditingController replyController =
                            TextEditingController();

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                  top: 20,
                                  right: 20,
                                  left: 20,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: replyController,
                                      decoration: InputDecoration(
                                        labelText: 'Your reply...',
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (replyController.text != "") {
                                          print('add reply');
                                          Navigator.pop(context);
                                          String newReply =
                                              replyController.text;
                                          print(newReply);
                                          Comment? nReply =
                                              await updateComments(
                                            id: widget.comment.id,
                                            content: newReply,
                                            type: 'reply',
                                          );
                                          setState(() {
                                            widget.comment.replies!
                                                .add(nReply!);
                                            print(
                                                'newComment${nReply!.content}');
                                          });
                                        }
                                      },
                                      child: Text('Reply'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).whenComplete(() {
                          replyController.dispose();
                        });
                      },
                      number: comment.likesCount,
                      upvoted: comment.isUpvoted!,
                      downvoted: comment.isDownvoted!,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!comment.isCollapsed && comment.replies != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: comment.replies!.map((reply) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                      margin: EdgeInsets.only(left: 8.0),
                      child: CommentCard(
                        comment: reply,
                        community: widget.community,
                      ),
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
