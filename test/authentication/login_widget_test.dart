import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/Sign_up/Presentaion/pages/log_in_page.dart';
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

  testWidgets('LogInScreen Widget Tests', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LogInScreen()));
    await tester.pumpAndSettle();
    
    // Check that all elements exist
    expect(find.byWidgetPredicate((widget) => widget is Header && widget.title == 'Log in to Spreadit',), findsOneWidget);
    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Log in to Spreadit'), findsOneWidget);
    expect(find.byType(CustomInput), findsNWidgets(2));
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Forgot Username?'), findsOneWidget);
    expect(find.byType(TermsAndCondText), findsOneWidget);


    // Check initial button color is grey when both inputs are empty
    expect(find.widgetWithText(Button, 'Continue'), findsOneWidget);
    final continueButton = tester.widget<Button>(find.widgetWithText(Button, 'Continue'));
    expect(continueButton.backgroundColor, equals(Color(0xFFEFEFED))); 

    // Entering data in the both fields and check if the button continue is orange now
    await tester.enterText(find.byType(CustomInput).first, 'testUsername');
    await tester.enterText(find.byType(CustomInput).last, 'testPassword');
    await tester.pump(); 
    expect(find.widgetWithText(Button, 'Continue'), findsOneWidget);
    final continueButton2 = tester.widget<Button>(find.widgetWithText(Button, 'Continue'));
    expect(continueButton2.backgroundColor, equals(Color(0xFFFF4500))); 

    //Entering data in username only 
    await tester.enterText(find.byType(CustomInput).first, 'testUsername');
    await tester.enterText(find.byType(CustomInput).last, '');
    await tester.pump(); 
    expect(find.widgetWithText(Button, 'Continue'), findsOneWidget);
    final continueButton3 = tester.widget<Button>(find.widgetWithText(Button, 'Continue'));
    expect(continueButton3.backgroundColor, equals(Color(0xFFEFEFED))); 

    //Entering data in the password only
    await tester.enterText(find.byType(CustomInput).first, 'testUsername');
    await tester.enterText(find.byType(CustomInput).last, '');
    await tester.pump(); 
    expect(find.widgetWithText(Button, 'Continue'), findsOneWidget);
    final continueButton4 = tester.widget<Button>(find.widgetWithText(Button, 'Continue'));
    expect(continueButton4.backgroundColor, equals(Color(0xFFEFEFED))); 
  }); 


 

}
