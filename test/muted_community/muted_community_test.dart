import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/presentation/widgets/muted_community_widget.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {

    setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });
  
  testWidgets('CommunityTile toggles mute state', (WidgetTester tester) async {
    // Create a mock community

     await tester.runAsync(() async {
      await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommunityTile(
            community: Community(name: 'Test Community', image: 'https://example.com/image.jpg', description: '', membersCount: 10),
            isMuted: false, // Initially unmuted
          ),
        ),
      ),
    );

    // Verify that the initial state is correct
    expect(find.text('Test Community'), findsOneWidget);
    expect(find.text('Mute'), findsOneWidget);
    expect(find.text('Unmute'), findsNothing);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap the ElevatedButton to mute the community
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the button text and color changed
    expect(find.text('Test Community'), findsOneWidget);
    expect(find.text('Mute'), findsNothing);
    expect(find.text('Unmute'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap the ElevatedButton again to unmute the community
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the button text and color changed back
    expect(find.text('Test Community'), findsOneWidget);
    expect(find.text('Mute'), findsOneWidget);
    expect(find.text('Unmute'), findsNothing);
    expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
