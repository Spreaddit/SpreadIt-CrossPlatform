import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/general_search.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/general_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/page_views/communities_page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_view.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/recent_searches.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/search_result_header.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/trending_widgets/trending_menu.dart';

void main() {

  setUpAll(() => HttpOverrides.global = null);

  group('SearchResults Tests', () {

    testWidgets('SearchResults widget renders correctly', (WidgetTester tester) async {
      final String searchItem = 'search_item';
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: SearchResult(searchItem: searchItem,),
          ),
        ));
      });

      // Check if intial widgets are present
      expect(find.byType(CustomSearchBar), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      //Check if SearchResultHeader is present and displays all labels
      expect(find.byType(SearchResultHeader), findsOneWidget);
      // Check if all 5 labels are present
      final labelsList = tester.widget<SearchResultHeader>(find.byType(SearchResultHeader)).labels;
      expect(labelsList.length, 5); 
      // Check if CustomPageView is present
      expect(find.byType(CustomPageView), findsOneWidget);
    });

    testWidgets('Tapping community label', (WidgetTester tester) async {
      final String searchItem = 'search_item';
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: SearchResult(searchItem: searchItem,),
          ),
        ));
      });

      final communityLabel = find.text('Communities');
      await tester.tap(communityLabel);
      // Find the CustomPageView widget
      final pageViewFinder = find.byType(CustomPageView);
      expect(pageViewFinder, findsOneWidget);
    });
  });
}
