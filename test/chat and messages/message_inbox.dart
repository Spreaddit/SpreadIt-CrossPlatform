import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/widgets/users_list.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';

void main() {
  testWidgets('Test loading state', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Builder(
            builder: (context) =>
                usersList(context: context, selectedOption: 1))));

    expect(find.byType(LoaderWidget), findsOneWidget);
  });

  testWidgets('Test error state', (WidgetTester tester) async {
    // Simulate snapshot error by passing null snapshot
    await tester.pumpWidget(MaterialApp(
        home: Builder(
            builder: (context) =>
                usersList(context: context, selectedOption: 1))));

    expect(find.text("An Error Occurred. Please Reload"), findsOneWidget);
  });

  testWidgets('Test data rendering', (WidgetTester tester) async {
    // Simulate snapshot with data
    await tester.pumpWidget(MaterialApp(
        home: Builder(
            builder: (context) =>
                usersList(context: context, selectedOption: 1))));

    // Verify that list items are rendered
    expect(find.byType(ListTile), findsWidgets);
  });

  testWidgets('Test mute/unmute action', (WidgetTester tester) async {
    // Simulate snapshot with data
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
            builder: (context) =>
                usersList(context: context, selectedOption: 1)),
      ),
    );

    // Tap on mute/unmute button
    await tester.tap(find.byKey(ValueKey('mute_unmute_button')));
    await tester.pump();

    // Verify that mute/unmute action works
    expect(find.text('UnMute'), findsOneWidget);

    // Tap again to unmute
    await tester.tap(find.byKey(ValueKey('mute_unmute_button')));
    await tester.pump();

    // Verify that user is unmuted
    expect(find.text('Mute'), findsOneWidget);
  });
}
