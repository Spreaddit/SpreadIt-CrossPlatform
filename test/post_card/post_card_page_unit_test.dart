import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/user_info.dart';

// Fake implementation of getPostById function
Future<Post?> fakeGetPostById({required String postId}) async {
  // Simulate fetching a post with the given ID
  return Post(
      postId: '1',
      userId: '2',
      username: 'rehab',
      date: DateTime.now(),
      userProfilePic: 'asdf',
      community: 'community',
      content: ["Test Post"]);
}

// Fake implementation of fetchCommentsData function
Future<List<Comment>> fakeFetchCommentsData(
    String userId, String postId) async {
  // Simulate fetching comments for the given post ID
  return [
    Comment(
      id: '1',
      content: 'Test Comment',
      likesCount: 5,
      createdAt: DateTime.now(),
    )
  ];
}

void main() {
  group('PostCardPage Widget Test', () {
    testWidgets('Widget renders correctly with post and comments',
        (WidgetTester tester) async {
      // Widget setup
      await tester.pumpWidget(MaterialApp(
        home: PostCardPage(postId: '1', isUserProfile: false),
      ));

      // Verify widgets
      expect(find.text('Test Post'), findsOneWidget);
      expect(find.text('Test Comment'), findsOneWidget);
    });
  });
}
