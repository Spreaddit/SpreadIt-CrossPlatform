import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/search/data/get_suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/general_search.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/recent_searches.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/suggested_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/trending_widgets/trending_menu.dart';

class MockGetSuggestedResults extends Mock implements GetSuggestedResults {}

void main() {
  final MockGetSuggestedResults mockGetSuggestedResults = MockGetSuggestedResults();
  setUpAll(() {
     HttpOverrides.global = null;
    });
  
  group('GeneralSearch Tests', () {

    testWidgets('GeneralSearch widget renders correctly', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: GeneralSearch(),
          ),
        ));
      });

      // Check if intial widgets are present
      expect(find.byType(CustomSearchBar), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.byType(RecentSearches), findsOneWidget); 
      expect(find.byType(TrendingMenu), findsOneWidget); 
      expect(find.byType(SuggestedResults), findsNothing);
    });

    testWidgets('Tapping the search bar displays the suggested results', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: GeneralSearch(),
          ),
        ));
      });

      // write a text in the search bar
      final searchBarFinder = find.byType(CustomSearchBar);
      await tester.tap(find.byType(CustomSearchBar));
      await tester.pumpAndSettle();
      await tester.enterText(searchBarFinder, 'test_search');
      await tester.pumpAndSettle();

      // Verify SuggestedResults are displayed
      expect(find.byType(SuggestedResults), findsOneWidget);
      expect(find.byType(RecentSearches), findsNothing); 
      expect(find.byType(TrendingMenu), findsNothing);
    });

    
}


