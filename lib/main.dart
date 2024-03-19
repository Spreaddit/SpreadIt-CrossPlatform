import 'package:flutter/material.dart';
import 'features/create_a_community/presentation/pages/create_a_community_page.dart';

void main() {
  runApp(const SpreadIt());
}

class SpreadIt extends StatelessWidget {
  const SpreadIt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spread It',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CreateCommunityPage(),
    );
  }
}
