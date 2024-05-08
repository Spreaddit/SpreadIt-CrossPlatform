import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spreadit_crossplatform/features/edit_post_comment/presentation/pages/edit_comment_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/comment_footer.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/image_picker.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/update_comments_list.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/add_comment.dart';
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
  final bool isLocked;
  final bool isRemoved;
  final bool isRemoval;

  /// Constructs a [_CommentHeader] widget with the given parameters.
  _CommentHeader({
    required this.username,
    required this.userId,
    required this.postId,
    required this.date,
    required this.isLocked,
    required this.isRemoval,
    required this.isRemoved,
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(width: 4), // Adjust the spacing as needed
                  if (isRemoval)
                    Icon(
                      Icons.shield,
                      color: const Color.fromARGB(255, 255, 89, 0),
                    ),
                ],
              ),
              Text(dateFormatted.value),
            ],
          ),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(profilePic),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLocked) Icon(Icons.lock, color: Colors.orange),
              if (isRemoved) Icon(Icons.delete, color: Colors.orange),
            ],
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
  final bool isPostLocked;
  final bool isModeratorView;
  final bool canManageComment;

  /// Constructs a [CommentCard] widget with the given parameters.
  CommentCard({
    required this.comment,
    required this.community,
    this.isPostLocked = false,
    this.isModeratorView = false,
    this.canManageComment = false,
    this.setIsLoaded,
    this.onecomment = false,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool _repliesFetched = false;
  late bool isUserProfile;
  bool isNotApprovedForEditOrReply = false;
  late bool isLocked;
  late bool isRemoved;
  var isSaved;
  File? uploadedImageFile;
  Uint8List? uploadedImageWeb;
  bool isImage = false;

  /// Fetches replies for the comment asynchronously.
  Future<void> fetchReplies() async {
    if (!_repliesFetched) {
      try {
        var data = await getCommentReplies(widget.comment.id);
        setState(() {
          widget.comment.replies = data;
          _repliesFetched = true;
          if (widget.onecomment) {
            widget.setIsLoaded!();
          }
        });
      } catch (e) {
        print('Error fetching comments: $e');
      }
    }
  }

  Future<void> pickImage() async {
    dynamic image;
    if (!kIsWeb) {
      image = await pickImageFromFilePicker();
    } else {
      image = await pickImageFromFilePickerWeb();
    }

    if (image != null) {
      setState(() {
        if (image is File) {
          uploadedImageFile = image;
          uploadedImageWeb = null;
        } else if (image is Uint8List) {
          uploadedImageFile = null;
          uploadedImageWeb = image;
        }
        isImage = true;
      });
    }
    print("image slected is $image");
    print("image file is $uploadedImageFile");
    print("image web is $uploadedImageWeb");
  }

  void onLock(bool newIsLocked) {
    print("lock comment: $newIsLocked");
    setState(() {
      isLocked = newIsLocked;
    });
  }

  void onSpam(bool newIsRemoved) {
    setState(() {
      isRemoved = newIsRemoved;
    });
  }

  void addReply(Comment nReply) {
    if (!mounted) return;
    setState(() {
      widget.comment.replies!.add(nReply);
      print('newComment${nReply.content}');
      //uploadedImageFile = null;
      //uploadedImageWeb = null;
    });
  }

  void onContentChanged(String newContent) {
    if (!mounted) return;

    setState(() {
      widget.comment.content = newContent;
    });
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
    isSaved = widget.comment.isSaved!;
    isLocked = widget.comment.isLocked!;
    isRemoved = widget.comment.isRemoved!;
    checkIfCanEditOrReply();
  }

  /// [checkIfCanEditOrReply] : a function used to check if users aren't approved for editing comments in the community

  void checkIfCanEditOrReply() async {
    await checkIfNotApproved(widget.community, UserSingleton().user!.username)
        .then((value) {
      isNotApprovedForEditOrReply = value;
    });
    setState(() {
      if (!mounted) return;
      isNotApprovedForEditOrReply = isNotApprovedForEditOrReply;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _repliesFetched
        ? _buildCommentWidget(widget.comment)
        : _buildShimmeringComment();
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
                      isLocked: isLocked,
                      isRemoved: isRemoved,
                      isRemoval: widget.comment.isRemoval!,
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
                      onLock: onLock,
                      onRemove: onSpam,
                      isRemoval: widget.comment.isRemoval!,
                      isRemoved: isRemoved,
                      communityName: comment.subredditName,
                      isPostLocked: widget.isPostLocked,
                      isCommentLocked: isLocked,
                      commentId: widget.comment.id,
                      isModeratorView: widget.isModeratorView,
                      canManageComment: widget.canManageComment,
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
                                isSaved ? "Unsave" : "save",
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
                                        isSaved,
                                      ),
                                      setState(() {
                                        isSaved = !isSaved;
                                      })
                                    },
                                if (isUserProfile &&
                                    !isNotApprovedForEditOrReply)
                                  () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditComment(
                                            comment: widget.comment,
                                            onContentChanged: onContentChanged,
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
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return AddCommentWidget(
                                commentsList: widget.comment.replies!,
                                postId: widget.comment.id,
                                addComment: addReply,
                                communityName: widget.community,
                                type: 'reply',
                                buttonText: 'Reply',
                                labelText: "Add a reply",
                              );
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
                        isModeratorView: widget.isModeratorView,
                        isPostLocked: widget.isPostLocked,
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

  Widget _buildShimmeringComment() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 16.0,
              ),
              SizedBox(width: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.0,
                    width: 100.0,
                    child: Container(color: Colors.white),
                  ),
                  SizedBox(height: 8.0),
                  SizedBox(
                    height: 12.0,
                    width: 200.0,
                    child: Container(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.0),
          SizedBox(
            height: 100.0,
            width: double.infinity,
            child: Container(color: Colors.white),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
