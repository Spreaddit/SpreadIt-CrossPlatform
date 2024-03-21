import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/create_a_community/presentation/pages/create_a_community_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';

void main() {
  testWidgets('Create a community page test', (WidgetTester tester) async {
    // Build the CreateCommunityPage in the widget tester
    await tester.pumpWidget(MaterialApp(home: CreateCommunityPage()));

    // Verify the presence of certain widgets
    expect(find.text('18+ community'), findsOneWidget);
    expect(find.text('Create community'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.byType(Button), findsOneWidget);

    // Tap the '18+ community' switch
    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();

    // Verify the switch changes state when tapped
    SwitchListTile switchListTile = tester.widget(find.byType(SwitchListTile));
    expect(switchListTile.value, isTrue);

    // Tap the TextButton to open the BottomSheet
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle(); // Wait for the BottomSheet to fully open

    // Verify the BottomSheet is displayed
    expect(find.byType(ModalBarrier), findsWidgets);

    // Tap the first option in the BottomSheet
    await tester.tap(find.text('Private'));
    await tester.pumpAndSettle(); // Wait for the BottomSheet to fully close

    // Verify the TextButton's text has changed
    TextButton button = tester.widget(find.byType(TextButton));
    expect(button.child, isA<Text>());
    expect((button.child as Text).data, 'Private');
  });
}
