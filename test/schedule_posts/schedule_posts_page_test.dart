import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/schedule_posts/presentation/pages/schedule_posts_card.dart';
import 'package:spreadit_crossplatform/features/schedule_posts/presentation/widgets/schedule_posts_body.dart';

void main() {
  testWidgets('SchedulePostsPage is created and contains ScheduledPostsBody',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SchedulePostsPage(communityName: 'Test Community'),
    ));

    // Wait for all widget lifecycles to complete.
    await tester.pumpAndSettle();

    // Verify that SchedulePostsPage is created.
    expect(find.byType(SchedulePostsPage), findsOneWidget);

    // Verify that ScheduledPostsBody is created.
    expect(find.byType(ScheduledPostsBody), findsOneWidget);
  });
}
