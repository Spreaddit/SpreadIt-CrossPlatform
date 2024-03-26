import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/forget_password/presentation/pages/forget_password_main.dart';



class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main(){
  CustomBindings();
  testWidgets('forget password widget test', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: Scaffold(body:ForgetPassword())));
    await tester.pumpAndSettle();
    // inspect header title
    expect(find.text('Forgot password?'), findsOneWidget);
    // inspect text 
    expect(find.text("Enter your email address or username and we'll send you a link to reset your password"), findsOneWidget);
    // inspcet button
    expect(find.text('Reset Password'), findsOneWidget);
    // inspect input field
    expect(find.byType(TextField), findsOneWidget);

    // Tap on the Reset Password button without entering any input.
    await tester.tap(find.text('Reset Password'));
    await tester.pump();
    // Expect a snackbar with error message because no input is provided.
    expect(find.text('please enter your email or username'), findsOneWidget);

    // Enter valid input.
    await tester.enterText(find.byType(TextField), 'test@example.com');
    await tester.pumpAndSettle();
    
    
  });

  }
  