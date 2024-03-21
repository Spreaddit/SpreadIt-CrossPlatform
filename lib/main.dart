import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/pages/homepage.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';

void main() {
  //dotenv.load(fileName: "lib/.env");
  runApp(SpreadIt());
}

class SpreadIt extends StatelessWidget {
  SpreadIt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spread It',
      theme: spreadItTheme,
      home: HomePage(),
    );
  }
}
