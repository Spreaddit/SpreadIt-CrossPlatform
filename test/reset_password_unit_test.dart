import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/widgets/generic/validations.dart';

import 'package:spreadit_crossplatform/main.dart';
import '../lib/features/reset_password/presentation/pages/reset_password_main.dart';

void main(){

  test('password is not empty', () {
    String initial ="";
    bool check = initial.isEmpty;
    expect(check, true);
  });

  test('password length > 8 characters' , () {
    String initial ="hello";
    bool check = validatePassword(initial);
    expect(check, false);
  });

  test('password is correctly provided' , () {
    String initial ="hello1234";
    bool check = validatePassword(initial);
    expect(check, true);
  });

  test('new password and confirmed password are identical', () {
    String newPass = "HelloWorld123";
    String confirmedPass = "HelloWorld123";
    bool check = (newPass == confirmedPass);
    expect(check, true);
  });

  test('new password and confirmed password are different', () {
    String newPass = "Hello123";
    String confirmedPass = "HelloWorld123";
    bool check = (newPass == confirmedPass);
    expect(check, false);
  });

}