import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/add_approved_page.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('AddApprovedPage widget test', (WidgetTester tester) async {
    // Build the AddApprovedPage widget
    await tester.pumpWidget(MaterialApp(
      home: AddApprovedPage(
        communityName: 'test_community',
        onRequestCompleted: () {}, // Mock onRequestCompleted function
      ),
    ));

    // Verify that the title is displayed
    expect(find.text('Add Approved User'), findsOneWidget);

    // Verify that the text field is initially empty
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('u/'), findsOneWidget);
    expect(find.text('username'), findsOneWidget);
    expect(find.text('This user will be able to submit content to your community.'), findsOneWidget);

    // Tap the add button without entering a username
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Verify that no snackbar is shown and the page remains
    expect(find.byType(CustomSnackbar), findsNothing);
    expect(find.byType(AddApprovedPage), findsOneWidget);

    // Verify the text field
    expect(find.byType(TextField), findsOneWidget);

    // Verify the add button
    expect(find.text('Add'), findsOneWidget);
  });

}
