import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import './features/pages/forget_password_main.dart';

void main() {
  runApp(const SpreadIt());
}

class SpreadIt extends StatelessWidget {
  const SpreadIt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spread It',
      theme: spreadItTheme,
      home: ForgetPassword(),
    );
  }
}
