import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/invite_moderator_page.dart';

void main() {
  testWidgets('InviteModeratorPage builds with initial state',
      (WidgetTester tester) async {
    // Create the widget by pumping it into the widget tester
    await tester.pumpWidget(MaterialApp(
        home: InviteModeratorPage(communityName: 'test_community')));

    // Verify the AppBar title
    expect(find.text('Invite Moderator'), findsOneWidget);

    // Verify the initial state of the button is disabled
    final addButtonFinder = find.byType(Button);
    final Button addButton = tester.widget(addButtonFinder) as Button;
    expect(
        addButton.onPressed, isNull); // The button should be disabled initially
  });
}
