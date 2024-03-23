import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/widgets/generic/validations.dart';

import 'package:spreadit_crossplatform/main.dart';
import '../lib/features/reset_password/presentation/widgets/generic/reset_password_widgets/reset_password_validations.dart';

void main(){

  test('current password is not empty 1', () {
    String currentPassword ="";
    bool check = checkCurrentPassExists(currentPassword);
    expect(check, false);
  });

  test('current password is not empty 2', () {
    String currentPassword ="Hello7896";
    bool check = checkCurrentPassExists(currentPassword);
    expect(check, true);
  });

  test(' all passwords length > 8 characters 1' , () {
    String currentPass ="hello";
    String newPass = "kdelfh1235";
    String confirmedPass = "iudkau647#";
    bool check = checkPasswordLength(currentPass, newPass, confirmedPass);
    expect(check, false);
  });

    test(' all passwords length > 8 characters 2' , () {
    String currentPass ="hello";
    String newPass = "kdelfh1235";
    String confirmedPass = "";
    bool check = checkPasswordLength(currentPass, newPass, confirmedPass);
    expect(check, false);
  });

    test(' all passwords length > 8 characters 3' , () {
    String currentPass ="hello645^7";
    String newPass = "kdelfh1235";
    String confirmedPass = "iudkau647#";
    bool check = checkPasswordLength(currentPass, newPass, confirmedPass);
    expect(check, true);
  });

  test('password is correctly provided' , () {
    String initial ="hello1234";
    bool check = validatePassword(initial);
    expect(check, true);
  });

  test('new password and confirmed password are identical 1', () {
    String newPass = "HelloWorld123";
    String confirmedPass = "HelloWorld123";
    bool check = checkIdentical(newPass, confirmedPass);
    expect(check, true);
  });

  test('new password and confirmed password are indentical 2', () {
    String newPass = "Hello123";
    String confirmedPass = "HelloWorld123";
    bool check = checkIdentical(newPass, confirmedPass);
    expect(check, false);
  });

}