import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/comment_footer.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/user.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/comments.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });
  testWidgets('CommentWidget test for saved page', (WidgetTester tester) async {
    // Create a mock comment
    final comment = Comment(
      id: 'comment_id',
      postId: 'post_id',
      postTitle: 'Test Post Title',
      subredditName: 'Test Subreddit',
      createdAt: DateTime.now(),
      content: 'Test Comment Content',
      media: [],
      user: User(username: 'test_user', id: '1', name: 'mimo'),
      likesCount: 10,
    );

    // Build the CommentWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommentWidget(comment: comment, saved: true),
        ),
      ),
    );

    // Verify that the post title is displayed
    expect(find.text('Test Post Title'), findsOneWidget);
    expect(find.text('Test Comment Content'), findsOneWidget);
    expect(find.byType(CommentFooter), findsOneWidget);
  });
  testWidgets('CommentWidget test for user profile page',
      (WidgetTester tester) async {
    final comment = Comment(
      id: 'comment_id',
      postId: 'post_id',
      postTitle: 'Test Post Title',
      subredditName: 'Test Subreddit',
      createdAt: DateTime.now(),
      content: 'Test Comment Content',
      media: [],
      user: User(username: 'test_user', id: '1', name: 'mimo'),
      likesCount: 10,
    );

    // Build the CommentWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommentWidget(comment: comment, saved: false),
        ),
      ),
    );

    // Verify that the post title is displayed
    expect(find.text('Test Comment Content'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (Widget widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName ==
                "assets/images/upvoteicon.png",
      ),
      findsOneWidget,
    );
  });
}
