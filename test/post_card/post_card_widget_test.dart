import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/post_caard.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';

void main() {
  testWidgets('PostCard Widget Test', (WidgetTester tester) async {
    // Create a post
    final post = Post(
        postId: 'post1',
        userId: "rehab",
        content: ['This is a test post'],
        username: 'Test User',
        community: 'Test Community',
        date: DateTime.now(),
        userProfilePic: "");

    // Create comments
    final comments = [
      Comment(
          id: 'comment1',
          content: 'This is a test comment',
          username: 'Commenter',
          postId: 'post1',
          createdAt: DateTime.now(),
          likesCount: 1),
      Comment(
          id: 'comment1',
          content: 'This is a test comment',
          username: 'Commenter',
          postId: 'post1',
          createdAt: DateTime.now(),
          likesCount: 1),
    ];

    // Pump the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostCard(
            post: post,
            comments: comments,
            isUserProfile: false,
          ),
        ),
      ),
    );

    // Verify that the post content is displayed
    expect(find.text('This is a test post'), findsOneWidget);

    // Verify that the comments are displayed
    expect(find.text('This is a test comment'), findsOneWidget);
    expect(find.text('Another test comment'), findsOneWidget);

    // Verify that the author names are displayed
    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('Commenter'), findsNWidgets(2));
    expect(find.text('Commenter2'), findsOneWidget);

    // Verify that the community name is displayed
    expect(find.text('Test Community'), findsOneWidget);
  });
}
