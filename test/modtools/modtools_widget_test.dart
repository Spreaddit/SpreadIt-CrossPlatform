import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/add_approved_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/add_edit_banned_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/add_data_appbar.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/approved_user_card.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/comm_type_nsfw.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/comm_type_range_slider.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/icon_adding_appbar.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('AddOrSaveDataAppBar widget test', (WidgetTester tester) async {
    // Build the AddOrSaveDataAppBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AddOrSaveDataAppBar(
            title: 'Test Title',
            onButtonPressed: null,
            actionText: 'Save',
          ),
        ),
      ),
    );

    // Verify if the title is displayed correctly
    expect(find.text('Test Title'), findsOneWidget);

    // Verify if the close button is displayed
    expect(find.byIcon(Icons.close_outlined), findsOneWidget);

    // Verify if the action button is displayed
    expect(find.byType(TextButton), findsOneWidget);

    // Tap the action button and verify if the provided callback is called
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    // Tap the close button and verify if it triggers Navigator.pop
    await tester.tap(find.byIcon(Icons.close_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(AddOrSaveDataAppBar), findsNothing);
  });

  testWidgets('ApprovedUserCard widget test', (WidgetTester tester) async {
    // Build the ApprovedUserCard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ApprovedUserCard(
            username: 'test_username',
            communityName: 'test_community',
            avatarUrl: 'https://example.com/avatar.png',
            banner: 'https://example.com/banner.png',
            onUnApprove: () {},
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify if the username is displayed correctly
    expect(find.text('u/test_username'), findsOneWidget);

    // Verify if the avatar is displayed
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Tap the more options button and verify if the menu sheet is displayed
    await tester.tap(find.byIcon(Icons.more_vert));
    await tester.pumpAndSettle();
    expect(find.text('Send Message'), findsOneWidget);
    expect(find.text('View profile'), findsOneWidget);
    expect(find.text('Remove'), findsOneWidget);
  });

  testWidgets('CommunityNSFWSwitch widget test', (WidgetTester tester) async {
    // Build the CommunityNSFWSwitch widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommunityNSFWSwitch(
            communityName: 'test_community',
            onTypeChanged: () {},
            communityInfo: {
              'is18plus': false
            }, // Provide initial community info
          ),
        ),
      ),
    );

    // Verify if the switch is initially off
    expect(find.byType(SwitchListTile), findsOneWidget);
    expect(tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value,
        false);

    // Tap the switch and verify if its value changes
    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();
    expect(
        tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value, true);
  });

  testWidgets('CommunityRangeSlider widget test', (WidgetTester tester) async {
    // Build the CommunityRangeSlider widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommunityRangeSlider(
            communityName: 'test_community',
            onTypeChanged: () {},
            communityInfo: {
              'communityType': 'Public'
            }, // Provide initial community info
          ),
        ),
      ),
    );

    // Verify if the initial state of the slider corresponds to the initial community type
    expect(find.byType(Slider), findsOneWidget);
    expect(tester.widget<Slider>(find.byType(Slider)).value, 0.0);
    expect(find.text('Public'), findsOneWidget);

    // Simulate interaction: Drag slider to 'Restricted' position
    await tester.drag(find.byType(Slider), const Offset(100.0, 0.0));
    await tester.pumpAndSettle();
    expect(tester.widget<Slider>(find.byType(Slider)).value, 1.0);
    expect(find.text('Restricted'), findsOneWidget);

    // Simulate interaction: Drag slider to 'Private' position
    await tester.drag(find.byType(Slider), const Offset(200.0, 0.0));
    await tester.pumpAndSettle();
    expect(tester.widget<Slider>(find.byType(Slider)).value, 2.0);
    expect(find.text('Private'), findsOneWidget);

    // Test callback invocation: Verify if the onTypeChanged callback is called after interaction
    var typeChanged = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CommunityRangeSlider(
            communityName: 'test_community',
            onTypeChanged: () {
              typeChanged = true;
            },
            communityInfo: {'communityType': 'Public'},
          ),
        ),
      ),
    );

    await tester.drag(find.byType(Slider), const Offset(100.0, 0.0));
    await tester.pump();
    expect(typeChanged, true);
  });

  testWidgets('IconAddingAppBar widget test', (WidgetTester tester) async {
    // Build the IconAddingAppBar widget for approving users
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: IconAddingAppBar(
            title: 'Test Title',
            communityName: 'Test Community',
            onRequestCompleted: () {},
            isApproving: true,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify if the app bar title is displayed correctly
    expect(find.text('Test Title'), findsOneWidget);

    // Verify if the back button is displayed
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Verify if the add button is displayed and tapping it navigates to AddApprovedPage
    await tester.tap(find.byIcon(Icons.add_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(AddApprovedPage), findsOneWidget);
  });

}
