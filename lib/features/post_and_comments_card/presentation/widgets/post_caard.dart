import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_post_comments.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';

class PostCard extends StatefulWidget {
  Post post;
  PostCard({
    required this.post,
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Comment> fetchedComments = await getPostComments(widget.post.postId);
    setState(() {
      comments = fetchedComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        /* padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 0,
        ),*/
        child: Column(children: [
          PostWidget(
            post: widget.post,
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
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CommentCard(comment: comments[index]),
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
