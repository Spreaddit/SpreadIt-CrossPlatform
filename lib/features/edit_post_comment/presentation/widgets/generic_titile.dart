import 'package:flutter/material.dart';

class GenericTitle extends StatefulWidget {
  final String title;
  final GlobalKey<FormState> formKey;
  final Function(String) onChanged;

  const GenericTitle({
    required this.title,
    required this.formKey,
    required this.onChanged,
  });

  @override
  State<GenericTitle> createState() => _GenericTitleState();
}

class _GenericTitleState extends State<GenericTitle> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    print('GenericContent initState');
    _controller = TextEditingController();
    print(_controller);
    print('controller initialized');
    _controller.addListener(() {
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
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      child: SingleChildScrollView(
        child: Form(
          key: widget.formKey,
          child: TextFormField(
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.title,
              hintStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            controller: _controller,
          ),
        ),
      ),
    );
  }
}
