import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/notifications/Data/notifications_class_model.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/widgets/get_according_to_type.dart';

class MockBuildContext extends Mock implements BuildContext {}


void main() {
  group('processNotification', () {
    test('Follow Notification', () {
      final mockContext = MockBuildContext();
      final notification = Notifications(
        notificationType: "Follow",
        relatedUser: RelatedUser(username: "test_user"),
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      final result = processNotification(notification, mockContext);

      expect(result.icon, equals(Icons.person_add));
      expect(result.content, equals(""));
      expect(result.buttonText, equals("View Profile"));
      expect(result.onPress, isNotNull);
    });

    test('Upvote Comments Notification', () {
      final mockContext = MockBuildContext();
      final notification = Notifications(
        notificationType: "Upvote Comments",
        post: PostNotification(title: "Test Post"),
        postId: "123",
        commentId: "456",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      final result = processNotification(notification, mockContext);

      expect(result.icon, equals(Icons.arrow_upward));
      expect(result.content, equals("Test Post"));
      expect(result.buttonText, isNull);
      expect(result.onPress, isNotNull);
    });

    test('Upvote Posts Notification', () {
      final mockContext = MockBuildContext();
      final notification = Notifications(
        notificationType: "Upvote Comments",
        post: PostNotification(title: "Test Post"),
        postId: "123",
        commentId: "456",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      final result = processNotification(notification, mockContext);

      expect(result.icon, equals(Icons.arrow_upward));
      expect(result.content, equals("Test Post"));
      expect(result.buttonText, isNull);
      expect(result.onPress, isNotNull);
    });

    test('Comment Reply Notification', () {
      final mockContext = MockBuildContext();
      final notification = Notifications(
        notificationType: "Comment Reply",
        comment: CommentNotification(content: "Test Comment"),
        postId: "123",
        commentId: "456",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      final result = processNotification(notification, mockContext);

      expect(result.icon, equals(Icons.reply));
      expect(result.content, equals("Test Comment"));
      expect(result.buttonText, equals("Reply"));
      expect(result.onPress, isNotNull);
    });

    test('Comment Notification', () {
      final mockContext = MockBuildContext();
      final notification = Notifications(
        notificationType: "Comment",
        comment: CommentNotification(content: "Test Comment"),
        postId: "123",
        commentId: "456",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      final result = processNotification(notification, mockContext);

      expect(result.icon, equals(Ionicons.chatbubble));
      expect(result.content, equals("Test Comment"));
      expect(result.buttonText, isNull);
      expect(result.onPress, isNotNull);
    });
    test('Community Notification', () {
      final mockContext = MockBuildContext();
      final notification = Notifications(
        notificationType: "community",
        communityname: "Test Community",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      final result = processNotification(notification, mockContext);

      expect(result.icon, equals(CupertinoIcons.bell));
      expect(result.content, equals("Recommended : Test Community"));
      expect(result.buttonText, isNull);
      expect(result.onPress, isNotNull);
    });

    test('Mention Notification', () {
      final mockContext = MockBuildContext();
      final notification = Notifications(
        notificationType: "mention",
        comment: CommentNotification(content: "Test Mention"),
        postId: "123",
        commentId: "456",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      final result = processNotification(notification, mockContext);

      expect(result.icon, equals(CupertinoIcons.person));
      expect(result.content, equals("Test Mention"));
      expect(result.buttonText, isNull);
      expect(result.onPress, isNotNull);
    });

    test('Account Update Notification', () {
      final mockContext = MockBuildContext();
      final notification = Notifications(
        notificationType: "Account Update",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      final result = processNotification(notification, mockContext);

      expect(result.icon, equals(Ionicons.ban));
      expect(result.content, equals(""));
      expect(result.buttonText, isNull);
      expect(result.onPress, isNotNull);
    });

    test('Invite Notification', () {
      final mockContext = MockBuildContext();
      final notification = Notifications(
        notificationType: "Invite",
        isRead: false,
        isHidden: false,
        createdAt: DateTime.now(),
      );

      final result = processNotification(notification, mockContext);

      expect(result.icon, equals(Ionicons.person));
      expect(result.content, equals(""));
      expect(result.buttonText, equals("Accept invitation"));
      expect(result.onPress, isNotNull);
    });
  });

  group('getNotificationType', () {
    test('Follow notification', () {
      final notification = Notifications(
          notificationType: "Follow",
          isRead: true,
          isHidden: false,
          createdAt: DateTime.now());

      final result = getNotificationType(notification);

      expect(result, "newFollowers");
    });

    test('Upvote Comments notification', () {
      final notification = Notifications(
          notificationType: "Upvote Comments",
          isRead: true,
          isHidden: false,
          createdAt: DateTime.now());

      final result = getNotificationType(notification);

      expect(result, "upvotes");
    });

    test('Upvote Posts notification', () {
      final notification = Notifications(
          notificationType: "Upvote Posts",
          isRead: true,
          isHidden: false,
          createdAt: DateTime.now());

      final result = getNotificationType(notification);

      expect(result, "upvotes");
    });

    test('Comment Reply notification', () {
      final notification = Notifications(
          notificationType: "Comment Reply",
          isRead: true,
          isHidden: false,
          createdAt: DateTime.now());

      final result = getNotificationType(notification);

      expect(result, "repliesToComments");
    });

    test('Comment notification', () {
      final notification = Notifications(
          notificationType: "Comment",
          isRead: true,
          isHidden: false,
          createdAt: DateTime.now());

      final result = getNotificationType(notification);

      expect(result, "commentsOnYourPost");
    });
  });
}
