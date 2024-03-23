import 'package:flutter_test/flutter_test.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';

void main() {

  test('email is not empty', () {
    String initial ="";
    bool check = initial.isEmpty;
    expect(check, true);
  });

  test('email is valid 1', () {
    String initial ="happyPanda";
    bool check = validateEmail(initial);
    expect(check, false);
  });

  test('email is valid 2', () {
    String initial ="happyPanda@gmail";
    bool check = validateEmail(initial);
    expect(check, false);
  });
  test('email is valid 3', () {
    String initial ="happyPanda@gmail.com";
    bool check = validateEmail(initial);
    expect(check, true);
  });

}