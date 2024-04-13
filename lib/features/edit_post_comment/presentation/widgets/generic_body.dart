import 'package:flutter/material.dart';

class GenericContent extends StatefulWidget {
  final String? bodyHint;
  final String? initialBody;
  final GlobalKey<FormState> formKey;
  final Function(String) onChanged;

  const GenericContent({
    required this.bodyHint,
    this.initialBody,
    required this.formKey,
    required this.onChanged,
  });

  @override
  State<GenericContent> createState() => _GenericContentState();
}

class _GenericContentState extends State<GenericContent> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    print('GenericContent initState');
    _controller = TextEditingController(text: widget.initialBody);
    print(_controller);
    print('controller initialized');
    _controller.addListener(() {
      print('GenericContent onChanged listener');
      setState(() {
        widget.onChanged(_controller.text);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
        child: SingleChildScrollView(
          child: TextFormField(
            // initialValue: widget.intialBody,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.bodyHint,
              hintStyle: TextStyle(
                fontSize: 20,
              ),
            ),
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 15,
            ),
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
