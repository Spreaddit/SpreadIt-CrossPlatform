import 'package:flutter/material.dart';

class FailToFetchPage extends StatelessWidget {
  const FailToFetchPage({Key? key, required this.displayWidget}) : super(key: key);

  final Widget displayWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: displayWidget,
      ),
    );
  }
}

class FailToFetchWidget extends StatelessWidget {
  const FailToFetchWidget({Key? key, required this.text}) : super(key: key);

  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: text,
      ),
    );
  }
}
