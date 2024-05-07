import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_bar.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/moderators-page.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('ModeratorsPage UI test', (WidgetTester tester) async {
    // Build the CommunityPage widget
    await tester.pumpWidget(MaterialApp(
      home: ModeratorsPage(
        communityName: 'TestCommunity',
      ),
    ));
    await tester.pumpAndSettle();
    // Verify that 'Moderators' text is displayed in the app bar
    expect(find.text('Moderators'), findsOneWidget);

    // Verify that the 'Search' icon button is displayed in the app bar
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Verify that the 'Add' icon button is displayed in the app bar
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Verify that the CustomBar widget with tabs ('All' and 'Editable') is displayed
    expect(find.byType(CustomBar), findsOneWidget);

    // Verify that the initial page content is displayed based on the selected tab ('All')
    expect(find.text('All'), findsOneWidget);

    // Verify that the 'Edit Permissions' bottom sheet is not visible initially
    expect(find.byType(CustomBottomSheet), findsNothing);
  });
}
