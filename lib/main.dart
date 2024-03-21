import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import 'package:spreadit_crossplatform/features/pages/blocked_accounts/blocked_accounts_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: BlockedAccountsPage(),
      ),
    ),
  );
}

class SpreadIt extends StatelessWidget {
  const SpreadIt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spread It',
      theme: spreadItTheme,
    );
  }
}
