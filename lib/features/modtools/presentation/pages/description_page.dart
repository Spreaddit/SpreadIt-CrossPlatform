import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  DescriptionPage({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}