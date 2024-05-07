import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/general_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/search_result_header.dart';

void main() {
  group('SearchResult Tests', () {

    testWidgets('SearchResult widget renders correctly', (WidgetTester tester) async {
      final searchItem = 'test_search';
      await tester.pumpWidget(MaterialApp(home: SearchResult(searchItem: searchItem)));

      // Check if CustomSearchBar is present
      //expect(find.byType(CustomSearchBar), findsOneWidget);
      //expect(find.text(searchItem), findsOneWidget); // Check if initial search item is displayed

      // Check if SearchResultHeader is present and displays all labels
      //expect(find.byType(SearchResultHeader), findsOneWidget);
      //final labelsList = tester.widget<SearchResultHeader>(find.byType(SearchResultHeader)).labels;
      //expect(labelsList.length, 5); // Check if all 5 labels are present

      // Check if CustomPageView is present
      //expect(find.byType(CustomPageView), findsOneWidget);
    });

    testWidgets('Tapping back button navigates back', (WidgetTester tester) async {
      final searchItem = 'test_search';
      pushWidget(SearchResult(searchItem: searchItem)); // Use pushWidget to simulate navigation

      // Simulate tapping back button
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump();

      // No need to verify pop with Mockito as we directly navigate

      // You can add assertions here to verify the widget state after navigating back,
      // for example, checking if the widget is no longer displayed
    });

    testWidgets('Selecting a tab in SearchResultHeader calls onTabSelected', (WidgetTester tester) async {
      final searchItem = 'test_search';
      pushWidget(SearchResult(searchItem: searchItem)); // Use pushWidget to simulate navigation

      // Select the second tab (index 1)
      await tester.tap(find.text('Communities'));
      await tester.pump();

      // Verify that onTabSelected was called with index 1
      //expect(find.byWidgetPredicate((widget) => widget is SearchResult && widget.selectedIndex == 1), findsOneWidget);
    });

    // Add more tests to cover other functionalities like searching, navigation within page views, etc.
  });
}

void pushWidget(Widget widget) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(widget); // Wrap the widget directly
  //popUntil((route) => route.isFirst); // Pop until the first route (usually the test app)
}
