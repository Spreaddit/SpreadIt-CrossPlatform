import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/history_page/history_page.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('history page test', (WidgetTester tester) async {
    // Build the HistoryPage in the widget tester
    await tester.pumpWidget(MaterialApp(home: HistoryPage()));
    await tester.pumpAndSettle();

    // Verify the presence of certain widgets
    expect(find.text('History'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.text("Recent"), findsOneWidget);
    expect(find.byType(PostFeed), findsOneWidget);
  });
}
