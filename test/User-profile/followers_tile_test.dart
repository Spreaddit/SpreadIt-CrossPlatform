import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/followers_tile.dart';

void main() {
  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });

  testWidgets('Renders correctly', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: FollowerListTile(
            username: 'example_username',
            avatarUrl: 'https://example.com/avatar.png',
            isFollowed: false,
          )),
        ),
      );

      expect(find.text('example_username'),
          findsNWidgets(2)); // Username in title and subtitle
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });
  });
}
