import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';

void main()
{
  test('email check', () {
    String intial ="mariammahrous@gmail.com";
    bool check = validateEmail(intial);
    expect(check, true);
  });

  test('email check2', () {
    String intial ="mariammahrous@gmail";
    bool check = validateEmail(intial);
    expect(check, false);
  });

  test('email check3', () {
    String intial ="mariammahrousgmail";
    bool check = validateEmail(intial);
    expect(check, false);
  });

  test('validate text username2', () {
    String intial ="mar";
    String check = validateusernametext(intial);
    expect(check, "Great name! it's not taken, so it's all yours.");
  });
 test('validate text username3', () {
    String intial ="mariam 23";
    String check = validateusernametext(intial);
    expect(check,"Username can only contain letters, numbers, dashes, and underscores." );
  });

  test('password check', () {
    String intial ="1234";
    bool check = validatePassword(intial);
    expect(check, false);
  });

  test('password check1', () {
    String intial ="";
    bool check = validatePassword(intial);
    expect(check, false);
  });

   test('password check1', () {
    String intial ="123456789";
    bool check = validatePassword(intial);
    expect(check, true);
  });

}