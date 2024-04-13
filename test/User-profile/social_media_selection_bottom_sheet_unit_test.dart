import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/social_media_button.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/social_media_selection_bottom_sheet.dart';

void main() {
  testWidgets('SocialMediaSelectionBottomSheet widget test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(
      home: SocialMediaSelectionBottomSheet(),
    ));

    // Verify if the app bar title is rendered correctly
    expect(find.text('Select Social Media Platform'), findsOneWidget);

    // Verify if the social media buttons are rendered correctly
    expect(find.byType(SocialMediaButton), findsNWidgets(12));
  });
}
