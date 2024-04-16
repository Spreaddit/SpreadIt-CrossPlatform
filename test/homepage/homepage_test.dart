import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/pages/all.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/pages/homepage.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/home_page_drawer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/sort_menu.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('home page test', (WidgetTester tester) async {
    // Build the HomePage in the widget tester
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    await tester.pumpAndSettle();

    // Verify the presence of certain widgets
    expect(find.text('Home'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byType(PostFeed), findsOneWidget);

    // Tap the 'HomeDrawer' switch
    await tester.tap(find.byIcon(Icons.account_circle));
    await tester.pumpAndSettle();

    // Verify the switch changes state when tapped
    expect(find.byType(HomePageDrawer), findsWidgets);

    // find buttons on drawer
    expect(find.byIcon(Icons.account_circle_outlined), findsOneWidget);
    expect(find.byIcon(Icons.bookmarks_outlined), findsOneWidget);
    expect(find.byIcon(Icons.watch_later_outlined), findsOneWidget);
  });
  testWidgets('Post feed sorting test (All Page)', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AllPage()));
    await tester.pumpAndSettle();
    // Expect to find SortTypeMenu dialog
    expect(find.byType(SortTypeMenu), findsOneWidget);

    // Tap on SortTypeMenu to change sort type
    await tester.tap(find.byType(SortTypeMenu));

    // Wait for the animation to complete
    await tester.pumpAndSettle();

    // Tap on a different sort type (e.g., Trending)
    await tester.tap(find.text('hot'));

    // Wait for data to be fetched with the new sort type
    await tester.pumpAndSettle();

    // Expect to find PostWidget after data is fetched with the new sort type
    expect(find.text('HOT POSTS'), findsWidgets);
  });
}
