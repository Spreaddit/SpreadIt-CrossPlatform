import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_post_comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/add_comment.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/post_caard.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/post_card_top_bar.dart';

class PostCardPage extends StatefulWidget {
  final int postId;
  final bool isUserProfile;

  const PostCardPage(
      {Key? key, required this.postId, required this.isUserProfile})
      : super(key: key);

  @override
  State<PostCardPage> createState() => _PostCardPageState();
}

class _PostCardPageState extends State<PostCardPage> {
  List<Comment> comments = [];
  Post? post;

  Future<void> fetchComments() async {
    try {
      var data = await fetchCommentsData('user', 'post', "${widget.postId}");
      setState(() {
        comments = data;
      });
      print(comments);
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  void addComment(Comment newComment) {
    setState(() {
      comments.add(newComment);
      print('newComment${newComment.content}');
    });
  }

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
    fetchPost().then((post) {
      fetchComments().then((comments) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PostCardTopBar(context,
          'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'), //String? accessToken = UserSingleton().user.avatar;
      body: Container(
        margin: EdgeInsets.all(10), // Add margin to the entire Column
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
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
                              isUserProfile: widget.isUserProfile,
                            )
                          : Text(""),
                    ],
                  ),
                ),
              ),
            ),
            AddCommentWidget(
              commentsList: comments,
              postId: widget.postId.toString(),
              addComment: addComment,
            ),
          ],
        ),
      ),
    );
  }
}
