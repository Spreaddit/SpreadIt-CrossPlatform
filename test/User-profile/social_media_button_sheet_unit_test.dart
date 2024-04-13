import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/social_link_bottom_sheet_model.dart';

void main() {
  
  testWidgets('SocialMediaBottomSheetContent widget test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SocialMediaBottomSheetContent(
          platformName: 'TestPlatform',
          icon: Icons.ac_unit,
          color: Colors.blue,
        ),
      ),
    ));

    // Verify if the widget is rendered correctly
    expect(find.text('Add Social Media'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
    expect(find.text('TestPlatform'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(CustomInput), findsNWidgets(2));
  });

  testWidgets('SocialMediaBottomSheet widget test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SocialMediaBottomSheet(
          platformName: 'TestPlatform',
          icon: Icons.ac_unit,
          color: Colors.blue,
        ),
      ),
    ));

    // Verify if the widget is rendered correctly
    expect(find.text('Add Social Media'), findsOneWidget);
    expect(find.text('TestPlatform'), findsOneWidget);
    expect(find.byType(SocialMediaBottomSheetContent), findsOneWidget);
  });
}
