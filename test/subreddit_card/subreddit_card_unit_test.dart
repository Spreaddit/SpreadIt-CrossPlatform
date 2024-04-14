import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/discover_communities/presentation/widgets/subreddit_cards.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('SubredditCard has a title and description',
      (WidgetTester tester) async {
    mockNetworkImagesFor(() async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: SubredditCard(
            index: 1,
            title: 'Test Title',
            description: 'Test Description',
            numberOfMembers: '1000',
            image: 'https://picsum.photos/200/300',
          ),
        ),
      ));

      // Wait for all widget lifecycles to complete.
      await tester.pumpAndSettle();

      // Simulate a delay of 1 second.
      await tester.pump(Duration(seconds: 1));

      // Verify that the title and description are displayed.
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('1000 members'), findsOneWidget);
    });
  });
}
