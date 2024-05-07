import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/data/muted_user_class_model.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_users/presentation/widgets/muted_user_tile.dart';
import 'dart:io';

void main() {

  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });

  testWidgets('MutedUserTile displays user information', (WidgetTester tester) async {
    // Create a MutedUser object for testing
    final mutedUser = MutedUser(
      username: 'test_user',
      userProfilePic: 'https://example.com/profile_pic.jpg',
      date: '2024-05-07',
      note: 'Test note',
    );

    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MutedUserTile(
              mutedUser: mutedUser,
              onTap: () {}, // Provide a dummy onTap callback
              communityName: 'Test Community',
              onUnmute: () {}, // Provide a dummy onUnmute callback
              onUpdate: (updatedUser) {}, // Provide a dummy onUpdate callback
            ),
          ),
        ),
      );

      // Verify that the user information is displayed correctly
      expect(find.text('u/test_user'), findsOneWidget);
      expect(find.text('2024-05-07  •  Test note'), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget); // Verify that the more_vert icon is displayed
    });
  });
}
