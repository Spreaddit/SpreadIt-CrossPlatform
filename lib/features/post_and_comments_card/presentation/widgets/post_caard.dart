import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Widget representing a post card.
class PostCard extends StatefulWidget {
  /// The post associated with this card.
  Post post;

  /// Indicates whether the current user is the owner of the post.

  /// List of comments associated with the post.
  List<Comment> comments;
  VoidCallback? setIsloaded;
  bool oneComment;

  /// Constructs a [PostCard] with the specified [post], [comments], and [isUserProfile] flag.
  PostCard({
    required this.post,
    required this.comments,
    this.setIsloaded,
    this.oneComment=false,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  /// Shows a bottom sheet for adding a link to the comment.
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
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        child: Column(children: [
          PostWidget(
            post: widget.post,
            isFullView: true,
            isUserProfile: widget.post.userId == UserSingleton().user!.id,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 216, 213, 213),
                      width: screenHeight * 0.005)),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.comments.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CommentCard(
                    comment: widget.comments[index],
                    community: widget.post.community,
                    setIsLoaded : widget.setIsloaded,
                    onecomment: widget.oneComment,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Color.fromARGB(255, 216, 213, 213),
                            width: screenHeight * 0.005),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ]),
      ),
    );
  }
}
