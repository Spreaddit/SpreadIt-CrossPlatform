import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/pages/homepage.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/home_page_drawer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';

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
    expect(find.byIcon(Icons.group), findsOneWidget);
    expect(find.byIcon(Icons.account_circle_outlined), findsOneWidget);
    expect(find.byIcon(Icons.bookmarks_outlined), findsOneWidget);
    expect(find.byIcon(Icons.watch_later_outlined), findsOneWidget);
  });
}
