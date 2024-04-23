import 'package:flutter/material.dart';

class DummyPage extends StatelessWidget {
  DummyPage({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Dummy Page: r/$communityName'),
    );
  }
}
