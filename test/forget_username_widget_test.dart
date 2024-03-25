import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/features/forget_username/presentation/pages/forget_username.dart';

void main() {
  testWidgets('forget password widget test', (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: Scaffold(body: ForgetUsername())));
    await tester.pumpAndSettle();

    // inspect header title
    expect(find.text("Forgot username?"), findsOneWidget);
    // inspect text
    expect(
        find.text(
            "Tell us the email address associated with your SpreadIt account, and we'll send you an email with your username"),
        findsOneWidget);
    // inspcet button
    expect(find.text("Email me"), findsOneWidget);
    // inspect input field
    expect(find.byType(TextField), findsOneWidget);

    // Tap on the Email me button without entering any input.
    await tester.tap(find.text("Email me"));
    await tester.pump();
    // Expect a snackbar with error message because no input is provided.
    expect(find.text("please enter a valid email"), findsOneWidget);

    // Enter an invalid email 1.
    await tester.enterText(find.byType(TextField), 'test@example');
    await tester.pump();
    // Tap on the Reset Password button again with valid input.
    await tester.tap(find.text("Email me"));
    await tester.pump();
    // Expect a snackbar indicating that an email was sent.
    expect(find.text("please enter a valid email"), findsOneWidget);

    // Enter an invalid email 2.
    await tester.enterText(find.byType(TextField), 'testexample.com');
    await tester.pump();
    // Tap on the Reset Password button again with valid input.
    await tester.tap(find.text("Email me"));
    await tester.pump();
    // Expect a snackbar indicating that an email was sent.
    expect(find.text("please enter a valid email"), findsOneWidget);

    // Enter a valid email .
    /*await tester.enterText(find.byType(TextField), 'test@example.com');
    await tester.pump();
    // Tap on the Reset Password button again with valid input.
    await tester.tap(find.text("Email me"));
    await tester.pump();
    // Expect a snackbar indicating that an email was sent.
    expect(find.text("Your username was sent to your email"), findsOneWidget);*/
  });
}
