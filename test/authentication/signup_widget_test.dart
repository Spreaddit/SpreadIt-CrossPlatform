import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/Sign_up/Presentaion/pages/sign_up_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/header.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/terms_and_cond_text.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('Sign up widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SignUpScreen()));
    await tester.pumpAndSettle();
    
    // Verfiy Ui at the start
    expect(find.byWidgetPredicate((widget) => widget is Header && widget.title == 'Hi new friend, Welcome to SpreadIt',), findsOneWidget);
    expect(find.text('Hi new friend, Welcome to SpreadIt'), findsOneWidget);
    expect(find.byType(CustomInput), findsNWidgets(2));
    expect(find.byType(TermsAndCondText), findsOneWidget);


    // Check initial button color is grey when both inputs are empty
    expect(find.widgetWithText(Button, 'Continue'), findsOneWidget);
    final continueButton = tester.widget<Button>(find.widgetWithText(Button, 'Continue'));
    expect(continueButton.backgroundColor, equals(Color(0xFFEFEFED))); 

    // Test email input field when entering a non valid email
    await tester.enterText(find.byType(CustomInput).first, 'testUsername');
    await tester.enterText(find.byType(CustomInput).last, 'password123');
    expect(find.text('Not a valid email address'), findsOneWidget);
    await tester.pump(); 
    expect(find.widgetWithText(Button, 'Continue'), findsOneWidget);
    final continueButton2 = tester.widget<Button>(find.widgetWithText(Button, 'Continue'));
    expect(continueButton2.backgroundColor, equals(Color(0xFFEFEFED))); 

   // Test when entering a non valid password
    await tester.enterText(find.byType(CustomInput).last, 'mimo');
    await tester.enterText(find.byType(CustomInput).first, 'testUsername@gmail.com');
    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    await tester.pump(); 
    expect(find.widgetWithText(Button, 'Continue'), findsOneWidget);
    final continueButton3 = tester.widget<Button>(find.widgetWithText(Button, 'Continue'));
    expect(continueButton3.backgroundColor, equals(Color(0xFFEFEFED))); 

    // Test when entering a valid and that continue button is now orange
    await tester.enterText(find.byType(CustomInput).first, 'testUsername@gmail.com');
    await tester.enterText(find.byType(CustomInput).last, 'mimo12345');
    await tester.pump(); 
    final continueButton5 = tester.widget<Button>(find.widgetWithText(Button, 'Continue'));
    expect(continueButton5.backgroundColor, equals(Color(0xFFFF4500))); 

  });

}
