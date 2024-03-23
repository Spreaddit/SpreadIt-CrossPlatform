import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/forget_password/presentation/pages/forget_password_main.dart';

void main() {
  testWidgets('forget password widget test', (WidgetTester tester) async {
    await tester.pumpWidget(ForgetPassword());
    await tester.pumpAndSettle();
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await tester.enterText(textField, "chz@gmail.com");
    expect(find.text("chz@gmail.com"), findsOneWidget);
    var button = find.text("Reset Password");
    expect(button, findsOneWidget);
    await tester.tap(button);
    await tester.pumpAndSettle();
  });
}
