import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/navigation_buttom_sheet.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/notification_widget.dart';

class MockFunction extends Mock {
  void call(String arg);
}

class MockFunction1 extends Mock {
  void call(String arg1, Notifications arg2);
}

void main() {
  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });
  group('NotificationWidget', () {

    testWidgets('Notification widget widget test', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: NotificationWidget(
                notification: Notifications(
                  notificationType: "Comment",
                  comment: CommentNotification(content: "Test Comment"),
                  relatedUser: RelatedUser(
                      avatarUrl:
                          'https://media.gettyimages.com/id/641697142/photo/landscape-of-cairo.jpg?s=612x612&w=gi&k=20&c=wDzngyj9rr5yyy6CP0HKbMHQh9S8mfvDaiHcJF8fwMU=',
                      username: 'mimo'),
                  postId: "123",
                  commentId: "456",
                  isRead: false,
                  isHidden: false,
                  createdAt: DateTime.now(),
                ),
                content: 'New comment on your post',
                date: "1h",
                iconData: Icons.comment,
                onPressed: () {},
                onHide: MockFunction1().call,
                disable: MockFunction().call,
                buttonText: 'View',
                buttonIcon: Icons.visibility,
                isRead: false,
                followed: true,
                community: false,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.comment), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);
        expect(find.byIcon(Icons.visibility), findsOneWidget);
        expect(find.text('View'), findsOneWidget);
      });
    });
  });
}
