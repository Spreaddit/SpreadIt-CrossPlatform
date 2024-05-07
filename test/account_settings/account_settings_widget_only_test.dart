import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/location_select_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/manage_notifications_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/connected_acc_only_dialog.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_btn_bottom_sheet.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_gender_modal.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_body.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_title.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/switch_type_2.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  
  testWidgets('SelectLocationPage widget test', (WidgetTester tester) async {
    // Build the SelectLocationPage widget
    await tester.pumpWidget(
      MaterialApp(
        home: SelectLocationPage(),
      ),
    );

    // Verify if the app bar title is displayed correctly
    expect(find.text('Select location'), findsOneWidget);

    // Verify if the list of available locations is displayed
    expect(find.byType(ListTile), findsWidgets);

    // Verify if some specific locations are present in the list
    expect(find.text('USA'), findsOneWidget);
    expect(find.text('Germany'), findsOneWidget);
    expect(find.text('UK'), findsOneWidget);
  });

  testWidgets('NotificationsPageUI widget test', (WidgetTester tester) async {
    // Build the NotificationsPageUI widget
    await tester.pumpWidget(
      MaterialApp(
        home: NotificationsPageUI(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify if the app bar title is displayed correctly
    expect(find.text('Notifications Settings'), findsOneWidget);

    // Verify if the section titles are displayed correctly
    expect(find.byType(SettingsSectionBody), findsAny);
    expect(find.byType(SettingsSectionTitle), findsAny);

    // Verify if the section bodies contain the expected number of SwitchBtn2 widgets
    expect(find.byType(SwitchBtn2), findsNWidgets(11)); // Total number of SwitchBtn2 widgets

  });

  testWidgets('ConnectedAccountOnlyDialog widget test', (WidgetTester tester) async {
    // Build the ConnectedAccountOnlyDialog widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  ConnectedAccountOnlyDialog(context, 0, 'test@example.com');
                },
                child: Text('Show Dialog'),
              );
            },
          ),
        ),
      ),
    );

    // Tap the button to show the dialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle(); // Wait for the dialog to be fully built

    // Verify if the dialog title is displayed correctly
    expect(find.text('Update email address'), findsOneWidget);

    // Verify if the dialog text is displayed correctly
    expect(find.text('To change your email address, you need to create a Reddit password first.'), findsOneWidget);

    // Verify if the Cancel button is displayed correctly
    expect(find.text('Cancel'), findsOneWidget);

    // Verify if the Ok button is displayed correctly
    expect(find.text('Ok'), findsOneWidget);
  });

  testWidgets('SettingsAppBar displays title and back button', (WidgetTester tester) async {
    // Build the SettingsAppBar widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: SettingsAppBar(title: 'Settings'),
        ),
      ),
    );

    // Find the SettingsAppBar widget
    final appBarFinder = find.byType(AppBar);

    // Verify that the AppBar is displayed
    expect(appBarFinder, findsOneWidget);

    // Verify that the title is displayed
    expect(find.text('Settings'), findsOneWidget);

    // Verify that the back button is displayed
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Tap the back button
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify that the back button navigates back to the previous screen
    expect(find.byType(SettingsAppBar), findsNothing);
  });

  testWidgets('SelectGender displays gender bottom sheet and saves gender', (WidgetTester tester) async {
    // Build the SelectGender widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SelectGender(
            basicData: {'gender': 'Male'}, // Mock basic data
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Tap the gender button to open the bottom sheet
    await tester.tap(find.byType(BottomModalBtn));
    await tester.pumpAndSettle();

    // Verify that the bottom sheet is displayed with gender options
    expect(find.text('Male'), findsAny);
    expect(find.text('Female'), findsAny);

    // Tap the 'Female' option
    await tester.tap(find.text('Female'));
    await tester.pumpAndSettle();

    // Verify that the gender is updated to 'Female'
    expect(find.text('Female'), findsOneWidget);

    // Tap the 'Done' button to save the gender
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

  });

}
