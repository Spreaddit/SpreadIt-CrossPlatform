import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/update_comments_list.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/add_comment.dart';

void main() {
  testWidgets(
      'Entering a comment and posting it should trigger addComment callback',
      (WidgetTester tester) async {
    // Create a list to store the comments
    List<Comment> commentsList = [];

    // Build the AddCommentWidget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AddCommentWidget(
          labelText: "Add a comment",
          type: "comment",
          buttonText: "Post",
          commentsList: commentsList,
          postId: 'post1',
          communityName: 'community1',
          addComment: (Comment comment) {
            commentsList.add(comment);
          },
        ),
      ),
    ));

    // Enter a comment in the TextFormField
    await tester.enterText(
        find.byType(TextFormField), 'This is a test comment');

    // Tap the post button
    await tester.tap(find.text('Post'));
    await tester.pumpAndSettle();

    // Retrieve the comment text from the TextFormField
    String commentText = tester
        .widget<TextFormField>(find.byType(TextFormField))
        .controller!
        .text;

    // Verify that the comment is added to the list
    expect(commentsList.length, 1);
    expect(commentText, 'This is a test comment');
  });
}
