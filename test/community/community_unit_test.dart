import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_about_page.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_page.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_about_desc.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_about_rules.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_app_bar.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_info_sect.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_post_feed.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('CommunityPage widget test', (WidgetTester tester) async {
    // Build the CommunityPage widget
    await tester.pumpWidget(MaterialApp(
      home: CommunityPage(communityName: 'test_community'),
    ));

    await tester.pumpAndSettle();

    // Verify that the CommunityAppBar is rendered
    expect(find.byType(CommunityAppBar), findsOneWidget);

    // Verify that the CommunityInfoSection is rendered
    expect(find.byType(CommunityInfoSection), findsOneWidget);

    // Verify that the PostFeed is rendered
    expect(find.byType(PostFeed), findsOneWidget);
  });

  testWidgets('CommunityAboutPage widget test', (WidgetTester tester) async {
    // Build the CommunityAboutPage widget
    await tester.pumpWidget(MaterialApp(
      home: CommunityAboutPage(communityName: 'test_community'),
    ));

    await tester.pumpAndSettle();

    // Verify that the CommunityAppBar is rendered
    expect(find.byType(CommunityAppBar), findsOneWidget);

    // Verify that the CommunityAboutDesc is rendered
    expect(find.byType(CommunityAboutDesc), findsOneWidget);

    // Verify that the CommunityAboutRules is rendered
    expect(find.byType(CommunityAboutRules), findsOneWidget);
  });

}
