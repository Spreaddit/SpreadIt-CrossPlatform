import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/pages/reset_password_main.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('reset password widget test', (WidgetTester tester) async {
    String currentPassword = '';
    String newPassword = '';
    String confirmedPassword = '';

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ResetPassword())));
    await tester.pumpAndSettle();

    // inspect current password input
    var currentPassField = find.descendant(
      of: find.widgetWithText(CustomInput, "Current password"),
      matching: find.byType(TextField),
    );
    expect(currentPassField, findsOneWidget);

    // inspect new password input
    var newPassField = find.descendant(
      of: find.widgetWithText(CustomInput, "New password"),
      matching: find.byType(TextField),
    );
    expect(newPassField, findsOneWidget);

    // inspect confirmed password input
    var confirmedPassField = find.descendant(
      of: find.widgetWithText(CustomInput, "Confirmed password"),
      matching: find.byType(TextField),
    );
    expect(confirmedPassField, findsOneWidget);

    // inspect save button
    expect(find.text("Save"), findsOneWidget);
    // inspect forget password button
    expect(find.text("Forgot password"), findsOneWidget);

    // Tap on the Save button without entering any input.
    await tester.tap(find.text('Save'));
    await tester.pump();
    // Expect a snackbar with error message because no input is provided.
    expect(find.text("provide your current password"), findsOneWidget);

    // check the passwords' length
    await tester.enterText(currentPassField, 'Hello');
    currentPassword =
        tester.widget<TextField>(currentPassField).controller!.text;
    await tester.enterText(newPassField, "Hello1234");
    newPassword = tester.widget<TextField>(newPassField).controller!.text;
    await tester.enterText(currentPassField, "Hello123456");
    confirmedPassword =
        tester.widget<TextField>(confirmedPassField).controller!.text;
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // check that the new password and the confirmed passwords are identical
    await tester.enterText(currentPassField, 'HelloThere');
    currentPassword =
        tester.widget<TextField>(currentPassField).controller!.text;
    await tester.enterText(newPassField, "Hello1234");
    newPassword = tester.widget<TextField>(newPassField).controller!.text;
    await tester.enterText(currentPassField, "Hello123456");
    confirmedPassword =
        tester.widget<TextField>(confirmedPassField).controller!.text;
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // inspect when all inputs are valid
    await tester.enterText(currentPassField, 'HelloThere');
    currentPassword =
        tester.widget<TextField>(currentPassField).controller!.text;
    await tester.enterText(newPassField, "Hello1234");
    newPassword = tester.widget<TextField>(newPassField).controller!.text;
    await tester.enterText(currentPassField, "Hello1234");
    confirmedPassword =
        tester.widget<TextField>(confirmedPassField).controller!.text;
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
  
  });
}
