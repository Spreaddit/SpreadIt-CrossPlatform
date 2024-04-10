import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/header.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/add_password_page.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();

  testWidgets('AddPasswordPage widget test', (WidgetTester tester) async {
    // Mock data
    final userData = {
      "username": "testuser",
      "connectedAccounts": ["testuser@example.com"]
    };

    // Build the AddPasswordPage widget
    await tester.pumpWidget(MaterialApp(
      home: AddPasswordPage(),
    ));

    await tester.pumpAndSettle();

    // Check if the widget renders properly
    expect(find.byType(AddPasswordPage), findsOneWidget);
    expect(find.byType(Header), findsOneWidget);
    expect(find.byType(CustomInput), findsNWidgets(2));
    expect(find.byType(Button), findsOneWidget);
    expect(find.text("Continue"), findsOneWidget);
  });
}
