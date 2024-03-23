import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:spreadit_crossplatform/main.dart';

void main() {
  testWidgets('reset password widget test', (WidgetTester tester) async{
    await tester.pumpWidget(SpreadIt());
    var currentPassTextField = find.widgetWithText(TextField,"Current password");
    expect(currentPassTextField, findsExactly(2));
    var newPassTextField = find.widgetWithText(TextField,"New password");
    expect(newPassTextField, findsExactly(2));
    var confirmedPassTextField = find.widgetWithText(TextField,"Confirmed password");
    expect(confirmedPassTextField, findsExactly(2));
    var saveButton = find.widgetWithText(Container,"Save");
    expect(saveButton,findsExactly(2));
    await tester.enterText(currentPassTextField, "Hello1234");
    expect(find.text("Hello1234"), findsAny);  // because the user could actually reset his new password with his current password
    await tester.enterText(newPassTextField, "HelloWorld12");
    await tester.enterText(confirmedPassTextField, "HelloWorld12");
    expect(find.text("HelloWorld12"), findsExactly(2));
    
  });
}