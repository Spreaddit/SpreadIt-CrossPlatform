import 'package:flutter/material.dart';

class LinkTextField extends StatefulWidget {

  final GlobalKey<FormState> formKey;
  final Function(String) onChanged;
  final String hintText;
  final String? initialBody;
  final VoidCallback onIconPress;

  const LinkTextField({
    required this.formKey,
    required this.onChanged,
    required this.hintText,
    this.initialBody,
    required this.onIconPress,
  });

  @override
  State<LinkTextField> createState() => _LinkTextFieldState();
}

class _LinkTextFieldState extends State<LinkTextField> {

  late TextEditingController _controller;
  
   @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text:widget.initialBody);
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
            padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
            child:SingleChildScrollView(
              child: TextFormField(  
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: widget.onIconPress ,
                  icon: Icon(Icons.cancel),
                  ),
                border: InputBorder.none,
                hintText: widget.hintText,
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
    );
  }
}

