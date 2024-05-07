import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/navigation_buttom_sheet.dart';

class MockFunction extends Mock {
  void call(String arg);
}

class MockFunction1 extends Mock {
  void call(String arg1, Notifications arg2);
}

void main() {
  group('ManageNotificationBottomSheet', () {
    testWidgets('Renders correctly for Comments Reply type',
        (WidgetTester tester) async {
      final mockDisableFunction = MockFunction();
      final mockHideFunction = MockFunction1();
      final notification = Notifications(
        notificationType: "Comment Reply",
        comment: CommentNotification(content: "Test Comment"),
        postId: "123",
        commentId: "456",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ManageNotificationBottomSheet(
              disable: mockDisableFunction.call,
              community: false,
              onHide: mockHideFunction.call,
              notification: notification,
            ),
          ),
        ),
      );

      expect(find.text('Manage Notifications'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_off), findsOneWidget);
      expect(find.text("Don't get updates on this"), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });

    testWidgets('Renders correctly for Comments type',
        (WidgetTester tester) async {
      final mockDisableFunction = MockFunction();
      final mockHideFunction = MockFunction1();
      final notification = Notifications(
        notificationType: "Comment",
        comment: CommentNotification(content: "Test Comment"),
        postId: "123",
        commentId: "456",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ManageNotificationBottomSheet(
              disable: mockDisableFunction.call,
              community: false,
              onHide: mockHideFunction.call,
              notification: notification,
            ),
          ),
        ),
      );

      expect(find.text('Manage Notifications'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_off), findsOneWidget);
      expect(find.text("Don't get updates on this"), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });

    testWidgets('Renders correctly for Community type',
        (WidgetTester tester) async {
      final mockDisableFunction = MockFunction();
      final mockHideFunction = MockFunction1();
      final notification = Notifications(
        notificationType: "community",
        communityname: "Test Community",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ManageNotificationBottomSheet(
              disable: mockDisableFunction.call,
              community: true,
              onHide: mockHideFunction.call,
              notification: notification,
            ),
          ),
        ),
      );

      expect(find.text('Manage Notifications'), findsOneWidget);
      expect(find.byIcon(Icons.do_not_disturb_on), findsOneWidget);
      expect(find.text('Disable updates from this community'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });

    testWidgets('Renders correctly for other types',
        (WidgetTester tester) async {
      final mockDisableFunction = MockFunction();
      final mockHideFunction = MockFunction1();
      final notification = Notifications(
        notificationType: "Upvote Posts",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ManageNotificationBottomSheet(
              disable: mockDisableFunction.call,
              community: false,
              onHide: mockHideFunction.call,
              notification: notification,
            ),
          ),
        ),
      );

      expect(find.text('Manage Notifications'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_off), findsOneWidget);
      expect(find.text('Turn off this notification type'), findsOneWidget);
      expect(find.text('Hide this notification'), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });

    testWidgets('Tap on Close Button', (WidgetTester tester) async {
      final mockDisableFunction = MockFunction();
      final mockHideFunction = MockFunction1();
      final notification = Notifications(
        notificationType: "Upvote Posts",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ManageNotificationBottomSheet(
              disable: mockDisableFunction.call,
              community: false,
              onHide: mockHideFunction.call,
              notification: notification,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Close'));
      await tester.pump();
      await tester.pump(
          Duration(milliseconds: 500));

      expect(find.text('Close'), findsNothing);
    });

  });
}
