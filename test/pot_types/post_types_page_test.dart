import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/switch_type_1.dart';
import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/presentation/pages/post_types_page.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('CommunityPage widget test', (WidgetTester tester) async {
    // Build the CommunityPage widget
    await tester.pumpWidget(MaterialApp(
      home: PostTypes(communityName: 'community'),
    ));

    await tester.pumpAndSettle();

    // Verify that the Post Types AppBaar is rendered
    expect(find.text('Post Types'), findsOneWidget);

    // Verify that the SwitchBtn1 is rendered
    expect(find.byType(SwitchBtn1), findsOneWidget);

    //  Verify that the save is rendered
    expect(find.text('Save'), findsOneWidget);
  });
}
