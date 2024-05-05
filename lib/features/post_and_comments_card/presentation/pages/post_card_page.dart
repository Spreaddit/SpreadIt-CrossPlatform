import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/non_skippable_dialog.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_post_comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/add_comment.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/post_caard.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/post_card_top_bar.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// Widget representing the page displaying a post card.
class PostCardPage extends StatefulWidget {
  /// The ID of the post.
  final String postId;
  bool isModeratorView;
  final String? commentId;
  final bool oneComment;

  /// Indicates whether the current user is the owner of the profile associated with the post.

  PostCardPage(
      {Key? key,
      required this.postId,
      this.isModeratorView = false,
      this.commentId,
      this.oneComment = false})
      : super(key: key);

  @override
  State<PostCardPage> createState() => _PostCardPageState();
}

class _PostCardPageState extends State<PostCardPage> {
  List<Comment> comments = [];
  Post? post;
  List<Comment> allComments = [];
  bool oneComment = false;
  bool isLoaded = false;
  late ScrollController _scrollController;

  void setIsloaded() {
    setState(() {
      isLoaded = true;
    });
    if (widget.oneComment && isLoaded) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool isNotApprovedForPostView = false;

  /// Fetches comments associated with the post.
  Future<void> fetchComments() async {
    try {
      var data = await fetchCommentsData('user', 'post', "${widget.postId}");
      setState(() {
        comments = data;
        allComments = data;
        if (widget.oneComment == true) {
          try {
            Comment? oneComment = comments
                .firstWhere((comment) => comment.id == widget.commentId);
            comments = [oneComment];
          } catch (e) {
            print('Comment not found with id: ${widget.commentId}');
          }
        }
      });

      print(comments);
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  /// Adds a new comment to the post.
  void addComment(Comment newComment) {
    setState(() {
      comments.add(newComment);
      print('newComment${newComment.content}');
    });
  }

  /// Fetches the post by its ID.
  Future<void> fetchPost() async {
    Post? fetchedPost = await getPostById(
      postId: widget.postId,
    );
    if (fetchedPost != null) {
      setState(() {
        post = fetchedPost;
        print(post.toString());
      });
    } else {
      print("no post found");
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    oneComment = widget.oneComment;
    fetchPost().then((post) {
      checkIfCanViewPost();
      fetchComments().then((comments) {
        setState(() {});
      });
    });
  }

  /// [checkIfCanViewPost] : a function used to check if users aren't approved for viewing the post in the community
  /// Shows a non-skippable alert dialog if the user is not approved to view the post.
  void checkIfCanViewPost() async {
    await checkIfBannedOrPrivate(
            post!.community, UserSingleton().user!.username)
        .then((value) {
      isNotApprovedForPostView = value;
    });
    if (isNotApprovedForPostView) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showHaltingAlert(title: "You are not approved to view this post");
      });
    }
  }

  /// Shows a non-skippable alert dialog.
  void _showHaltingAlert({required String title, String? content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NonSkippableAlertDialog(
          title: title,
          content: content,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PostCardTopBar(context, UserSingleton().user?.avatarUrl ?? ""),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                controller: _scrollController,
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Divider(
                          height: 0.5,
                        ),
                      ),
                      post != null
                          ? PostCard(
                              post: post!,
                              comments: comments,
                              isModeratorView: widget.isModeratorView,
                              setIsloaded: setIsloaded,
                              oneComment: widget.oneComment,
                            )
                          : Text(""),
                    ],
                  ),
                ),
              ),
            ),
            if (oneComment && isLoaded)
              Button(
                onPressed: () {
                  setState(() {
                    oneComment = false;
                    comments = allComments;
                  });
                },
                text: 'View all comments',
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                foregroundColor: Colors.white,
              ),
            if (post != null && !post!.isCommentsLocked! ||
                widget!.isModeratorView!)
              AddCommentWidget(
                commentsList: comments,
                postId: widget.postId.toString(),
                addComment: addComment,
                communityName: post!.community,
              ),
          ],
        ),
      ),
    );
  }
}
