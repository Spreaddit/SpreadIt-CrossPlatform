import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/createusername.dart';
import 'package:spreadit_crossplatform/features/sign_up/Presentaion/pages/sign_up_page.dart';

void main() {
 testWidgets('Create username test', (WidgetTester tester) async {
    // Build the CreateUsernamePage widget
    await tester.pumpWidget(MaterialApp(
      initialRoute: '/sign-up-page',
      routes: {
        '/create-username-page': (context) => CreateUsername(),
        '/sign-up-page': (context) => SignUpScreen(),
      },
    ));
    //add input in feilds
    await tester.enterText(
        find.byType(CustomInput).first, 'testUsername@gmail.com');
    await tester.enterText(find.byType(CustomInput).last, 'mimo12345');
    await tester.pump();

    // Tap the button to navigate
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.byType(CustomInput), findsNWidgets(1));
    expect(find.text('Continue'), findsOneWidget);
  });


  
}
