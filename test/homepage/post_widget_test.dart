import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();

  group('PostWidget', () {
    testWidgets('PostWidget displays title and user correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PostWidget(
              post: Post(
                postId: '123',
                userId: '456',
                username: 'example_user',
                userProfilePic: 'https://example.com/profile_pic.jpg',
                votesUpCount: 0,
                votesDownCount: 0,
                sharesCount: 0,
                commentsCount: 0,
                numberOfViews: 0,
                date: DateTime.now(),
                title: 'Test Title',
                content: ['Test Content'],
                community: 'example_community',
                isNsfw: false,
                isSpoiler: false,
                type: "Post",
              ),
              isUserProfile: false,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('example_user'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
      expect(find.text('0'), findsNWidgets(3));
    });
  });
}
