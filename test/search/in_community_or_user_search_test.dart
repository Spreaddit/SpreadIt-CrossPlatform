import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/in_community_or_user_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/pages/search_in_community_or_user.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/best_and_new_widgets.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/custom_search_bar.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);
  group('InCommunityOrUserSearch Tests', () {

    testWidgets('InCommunityOrUserSearch widget renders correctly', (WidgetTester tester) async {
      String communityOrUserName = 'r/Random';
      String communityOrUserIcon = 'https://example.com/image.jpg';
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
            body: SearchInCommunityOrUser(
              communityOrUserIcon: communityOrUserIcon  ,
              communityOrUserName: communityOrUserName,
              fromCommunityPage: true,
              fromUserProfile: false,
            ),
          ),
        ));
      });

      // Check if intial widgets are present
      expect(find.byType(CustomSearchBar), findsOneWidget);
      expect(find.text(communityOrUserName), findsOneWidget);
      expect(find.byType(BestAndNewWidget), findsExactly(2));
      expect(find.text('Cancel'), findsOneWidget);
    });
  }); 

  testWidgets('InCommunityOrUserSearch widget renders correctly', (WidgetTester tester) async {
    String communityOrUserName = 'r/Random';
    String communityOrUserIcon = 'https://example.com/image.jpg';
    await tester.runAsync(() async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SearchInCommunityOrUser(
            communityOrUserIcon: communityOrUserIcon  ,
            communityOrUserName: communityOrUserName,
            fromCommunityPage: true,
            fromUserProfile: false,
          ),
        ),
      ));

      final searchBarFinder = find.byType(CustomSearchBar);
      await tester.tap(find.byType(CustomSearchBar));
      await tester.pumpAndSettle();
      await tester.enterText(searchBarFinder, 'test_search');
      await tester.pumpAndSettle();

    });
  });
}

