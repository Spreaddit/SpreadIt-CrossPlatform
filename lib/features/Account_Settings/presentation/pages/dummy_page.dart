import 'package:flutter/material.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dummy Page'), shadowColor: Colors.grey, elevation: 4.0,),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Useless Button, Use the AppBar Icon To Return'),
        ),
      ),
    );
  }
}
