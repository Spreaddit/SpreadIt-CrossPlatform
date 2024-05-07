import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/presentation/widgets/post_options_widget.dart';

void main() {
  testWidgets('PostOptionsBox widget test', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PostOptionsBox(
          onOptionSelected: (String selectedOption) {},
          initialOption: 'any',
        ),
      ),
    ));

    // Verify that 'Post Options' text is rendered
    expect(find.text('Post Options'), findsOneWidget);

    // Verify that initial option is rendered
    expect(find.text('any'), findsOneWidget);

    // Tap on the widget to open the options modal
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    // Verify that the modal bottom sheet is displayed
    expect(find.byType(BottomSheet), findsOneWidget);

    // Tap on 'text posts only' option
    await tester.tap(find.text('text posts only'));
    await tester.pumpAndSettle();

    // Verify that the selected option is updated
    expect(find.text('text posts only'), findsOneWidget);

    // Tap on the widget again to open the options modal
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    // Tap on 'links only' option
    await tester.tap(find.text('links only'));
    await tester.pumpAndSettle();

    // Verify that the selected option is updated again
    expect(find.text('links only'), findsOneWidget);
  });
}
