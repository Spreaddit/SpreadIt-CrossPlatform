import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_post_comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/update_comments_list.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Widget for adding a comment to a post.
class AddCommentWidget extends StatefulWidget {
  /// List of comments associated with the post.
  List<Comment> commentsList;

  /// ID of the post to which the comment is being added.
  String postId;

  /// Function to add a comment.
  final Function(Comment) addComment;

  /// Name of the community.
  final String communityName;

  /// Constructs an [AddCommentWidget] with the specified [commentsList], [postId], and [addComment] function.
  AddCommentWidget(
      {required this.commentsList,
      required this.postId,
      required this.addComment,
      required this.communityName});

  @override
  State<AddCommentWidget> createState() {
    return _AddCommentWidgetState();
  }

  /// Retrieves the text of the comment.
  String getCommentText() {
    return _AddCommentWidgetState()._commentController.text;
  }
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isNotApprovedForCommenting = false;

  @override
  void initState() {
    super.initState();
    checkIfCanComment();
  }

  /// [checkIfCanComment] : a function used to check if users aren't approved for commenting in the community

  void checkIfCanComment() async {
    if (widget.communityName == "") {
      return;
    }
    await checkIfNotApproved(
            widget.communityName, UserSingleton().user!.username)
        .then((value) {
      isNotApprovedForCommenting = value;
    });
    setState(() {
      //TODO: check if this causes exception
      isNotApprovedForCommenting = isNotApprovedForCommenting;
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _commentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Link name',
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _linkController,
                  decoration: InputDecoration(
                    labelText: 'https://',
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String linkName = '[${_commentController.text}]';
                    String link = '(${_linkController.text})';
                    String finalLink = '$linkName $link';

                    _commentController.text = finalLink;

                    _linkController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Add link'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Expanded(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: TextFormField(
            controller: _commentController,
            maxLines: null,
            decoration: InputDecoration(
              labelText: "Add a comment",
              suffixIcon: IconButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                icon: Icon(Icons.link),
              ),
            ),
          ),
        ),
      ),
      trailing: OutlinedButton(
        onPressed: isNotApprovedForCommenting
            ? () {
                CustomSnackbar(
                  content:
                      "You are not approved for commenting in this community",
                ).show(context);
              }
            : () async {
                print("commenting: $isNotApprovedForCommenting");
                if (_commentController.text != "") {
                  print('add comment');
                  FocusScope.of(context).unfocus();
                  String newComment = _commentController.text;
                  _commentController.clear();
                  Comment? nComment = await updateComments(
                    id: widget.postId,
                    content: newComment,
                    type: 'comment',
                  );
                  setState(() {
                    widget.addComment(nComment!);
                    print('nComment${nComment.content}');
                  });
                }
              },
        child: Text("Post"),
      ),
    );
  }
}
