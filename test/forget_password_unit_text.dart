import 'package:flutter_test/flutter_test.dart';

void main() {
  test('email or username is not empty', () {
    String initial = "";
    bool check = initial.isEmpty;
    expect(check, true);
  });

  test('email or username is not empty', () {
    String initial = "happyPanda";
    bool check = initial.isNotEmpty;
    expect(check, true);
  });
}
