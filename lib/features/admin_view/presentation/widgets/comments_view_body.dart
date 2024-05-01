import 'package:flutter/material.dart';

class CommentsViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Replace this with your actual data fetching logic
    final comments = ['Comment 1', 'Comment 2', 'Comment 3'];

    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(comments[index]),
          // TODO: Add more details about the comment
        );
      },
    );
  }
}
