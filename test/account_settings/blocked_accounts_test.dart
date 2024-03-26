import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/presentation/blocked_accounts_page.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();

  testWidgets('BlockedAccountsPage Widgets Test', (WidgetTester tester) async {
    // Build the BlockedAccountsPage widget
    await tester.pumpWidget(MaterialApp(home: BlockedAccountsPage()));
    await tester.pumpAndSettle();

    // Verify if the Blocked Accounts bar is displayed correctly
    expect(find.text("Blocked Accounts"), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    //Verify Intial State of the page (empty)
    expect(find.byType(ListTile), findsNothing);
    expect(find.byKey(Key('EmptyStateImage')), findsOneWidget);
  });
}
