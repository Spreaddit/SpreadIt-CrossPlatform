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
  Post? post;

  PostCardPage({this.post});
  @override
  State<PostCardPage> createState() => _PostCardPageState();
}

class _PostCardPageState extends State<PostCardPage> {
  List<Comment> comments = [];

  /* Future<void> fetchData() async {
    List<Comment> fetchedComments = await getPostComments(widget.post!.postId);
    setState(() {
      comments = fetchedComments;
    });
  }*/

  Future<void> fetchComments() async {
    try {
      var data =
          await fetchUserComments('user', 'post', "${widget.post!.postId}");
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

  @override
  void initState() {
    super.initState();
    // fetchData();
    fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PostCardTopBar(context,
          'https://ladygeekgirl.files.wordpress.com/2016/08/steven-universe-pearl.png'), //take the users pfp
      body: Column(
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
                    PostCard(
                      post: widget.post!,
                      comments: comments,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AddCommentWidget(
            commentsList: comments,
            postId: widget.post!.postId.toString(),
            addComment: addComment,
          ),
        ],
      ),
    );
  }
}
