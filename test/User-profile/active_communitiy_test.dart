import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/active_community.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'dart:io';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });

  testWidgets('Active Community widget test', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ActiveCommunity(
                community: Community(
              name: 'TestCommunity',
              backgroundImage: 'https://example.com/background_image.jpg',
              image: 'https://example.com/image.jpg',
              membersCount: 100,
              description: 'ayhaga',
            )),
          ),
        ),
      );
      expect(find.text('r/TestCommunity'), findsOneWidget);
      expect(find.text('100 members'), findsOneWidget);
    });
  });
}
