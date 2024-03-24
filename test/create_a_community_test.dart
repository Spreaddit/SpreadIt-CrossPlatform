import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/create_a_community/presentation/pages/create_a_community_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';

void main() {
  testWidgets('Initial state of CreateCommunityPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateCommunityPage()));

    expect(find.text('18+ community'), findsOneWidget);
    expect(find.text('Create community'), findsOneWidget);
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(find.byType(Button), findsOneWidget);
  });

  testWidgets('Switch changes state when tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateCommunityPage()));

    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();

    SwitchListTile switchListTile = tester.widget(find.byType(SwitchListTile));
    expect(switchListTile.value, isTrue);
  });

  testWidgets('BottomSheet is displayed when TextButton is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateCommunityPage()));

    await tester.tap(find.byKey(Key('communityTypeGestureDetector')));
    await tester.pumpAndSettle();

    expect(find.byType(ModalBarrier), findsWidgets);
  });

  testWidgets('TextButton text changes when option is selected',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CreateCommunityPage()));

    await tester.tap(find.byKey(Key('communityTypeGestureDetector')));
    await tester.pumpAndSettle();

    await tester.tap(find.text(' Private '));
    await tester.pumpAndSettle();

    Text communityTypeText =
        tester.widget(find.byKey(Key('communityTypeText')));
    expect(communityTypeText.data, 'Private');
  });
}
