import 'package:flutter/material.dart';

class CreateCommunityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Community'),
      ),
      body: Center(
        child: Text(
          'Create Community Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
