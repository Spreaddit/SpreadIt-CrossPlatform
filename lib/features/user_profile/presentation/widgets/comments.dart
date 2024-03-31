import 'package:flutter/material.dart';
import '../../data/comments.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  CommentWidget({required this.comment});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.postTitle,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(children: [
            Text(
              '${comment.communityTitle} • ${comment.time} •  ${comment.votes} ',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
            Image.asset(
              "assets/images/upvoteicon.png",
              height: screenHeight * 0.015,
              color: Colors.grey,
            ),
          ]),
          SizedBox(height: screenHeight * 0.02),
          Text(
            comment.content,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
