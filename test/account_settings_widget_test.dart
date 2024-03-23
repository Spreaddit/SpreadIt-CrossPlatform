import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/account_settings_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/change_password_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/location_select_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/manage_notifications_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/update_email_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/connected_acc_btn.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_btn_to_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_followers_sect.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_gender_modal.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/presentation/blocked_accounts_page.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();

  testWidgets('AccountSettingsPage Simple UI and NAV Test',
      (WidgetTester tester) async {
    // Build the AccountSettingsPage widget
    await tester.pumpWidget(MaterialApp(home: AccountSettingsPage()));
    await tester.pumpAndSettle();

    // Verify if the basic settings section is displayed correctly
    expect(find.text("BASIC SETTINGS"), findsOneWidget);
    expect(find.byType(ToPageBtn), findsWidgets);

    // Simulate navigation to UpdateEmailPage
    await tester.tap(find.text("Update email address", findRichText: true));
    await tester.pumpAndSettle();
    expect(find.byType(UpdateEmailPage), findsOneWidget);

    // Simulate tapping on the back button in the SettingsAppBar
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify if we are back on the AccountSettingsPage
    expect(find.text("BASIC SETTINGS"), findsOneWidget);

    // Simulate navigation to ChangePasswordPage
    await tester.tap(find.text("Change password", findRichText: true));
    await tester.pumpAndSettle();
    expect(find.byType(ChangePasswordPage), findsOneWidget);

    // Simulate tapping on the back button in the SettingsAppBar
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify if we are back on the AccountSettingsPage
    expect(find.text("BASIC SETTINGS"), findsOneWidget);

    // Simulate navigation to SelectLocationPage
    await tester.tap(find.text("Location customization", findRichText: true));
    await tester.pumpAndSettle();
    expect(find.byType(SelectLocationPage), findsOneWidget);

    // Simulate tapping on the back button in the SettingsAppBar
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify if we are back on the AccountSettingsPage
    expect(find.text("BASIC SETTINGS"), findsOneWidget);

    // Simulate navigation to NotificationsPageUI
    await tester.tap(find.text("Manage notifications", findRichText: true));
    await tester.pumpAndSettle();
    expect(find.byType(NotificationsPageUI), findsOneWidget);

    // Simulate tapping on the back button in the SettingsAppBar
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify if we are back on the AccountSettingsPage
    expect(find.text("BASIC SETTINGS"), findsOneWidget);

    // Simulate navigation to BlockedAccountsPage
    await tester.tap(find.text("Manage blocked accounts", findRichText: true));
    await tester.pumpAndSettle();
    expect(find.byType(BlockedAccountsPage), findsOneWidget);

    // Simulate tapping on the back button in the SettingsAppBar
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify if we are back on the AccountSettingsPage
    expect(find.text("BASIC SETTINGS"), findsOneWidget);
  });

  testWidgets('AccountSettingsPage Gender Modal Test',
      (WidgetTester tester) async {
    // Build the AccountSettingsPage widget
    await tester.pumpWidget(MaterialApp(home: AccountSettingsPage()));
    await tester.pumpAndSettle();
    // Verify if SelectGender widget exists
    expect(find.byType(SelectGender), findsOneWidget);

    // Tap on SelectGender widget to show modal bottom sheet
    await tester.tap(find.byType(SelectGender));
    await tester.pumpAndSettle();

    // Verify if the modal bottom sheet is displayed
    expect(find.byType(BottomSheet), findsOneWidget);
  });

  testWidgets('AccountSettingsPage Widgets Test', (WidgetTester tester) async {
    // Build the AccountSettingsPage widget
    await tester.pumpWidget(MaterialApp(home: AccountSettingsPage()));
    await tester.pumpAndSettle();

    // Verify if ConnectAccBtn widget exists
    expect(find.byType(ConnectAccBtn), findsOneWidget);

    // Verify if SwitchSection widget exists
    expect(find.byType(SwitchSection), findsOneWidget);
  });
}
