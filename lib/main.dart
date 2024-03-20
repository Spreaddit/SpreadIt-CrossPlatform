import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import 'features/reset_password/presentation/pages/reset_password_main.dart';
import 'features/reset_password/presentation/pages/random_page.dart';

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
      home: ResetPassword(),
      routes: {
        '/forgetPasswordPage': (context) => RandomPage() , 
      }
    );
  }
}
