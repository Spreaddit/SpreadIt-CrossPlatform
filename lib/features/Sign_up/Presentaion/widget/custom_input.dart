import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool validate;
  final Function(String, bool) onChanged;
  final String label;
  final String placeholder;
  final bool obscureText;
  bool isFieldValid;

  CustomInput({
    required this.formKey,
    required this.onChanged,
    required this.label,
    required this.placeholder,
    this.obscureText = false,
    this.validate = false,
    this.isFieldValid = true,

  });

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late TextEditingController _controller;
  late String fieldValue;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        fieldValue = _controller.text;
        if (widget.validate) {
          widget.onChanged(fieldValue, validateField(fieldValue));
        } else {
          widget.onChanged(fieldValue, true);
        }
      });
    });
  }

  bool validateField(String value) {
    if (!widget.validate)
    {
      return fieldValue.isNotEmpty;
    }
    if (widget.placeholder=="Password")
    {
      setState(() {
        widget.isFieldValid = fieldValue.isNotEmpty && fieldValue.length >= 8;
      });
      return fieldValue.isNotEmpty && fieldValue.length >= 8;
    }
    else if (widget.placeholder.contains('Email')){
       setState(() {
        widget.isFieldValid = fieldValue.isNotEmpty && fieldValue.contains('@') && fieldValue.contains('.');
      });
      return fieldValue.isNotEmpty && fieldValue.contains('@') && fieldValue.contains('.');
    }
    return fieldValue.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          color: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Form(
              key: widget.formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: widget.label,
                      labelStyle: TextStyle(fontSize: 14),
                      hintText: widget.placeholder,
                      border: InputBorder.none,
                      suffixIcon: widget.obscureText
                          ? IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            )
                          : (_controller.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    setState(() {
                                      _controller.clear();
                                      fieldValue = '';
                                      widget.onChanged('', false);
                                    });
                                  },
                                )
                              : null),
                    ),
                    controller: _controller,
                    obscureText: widget.obscureText && !_isPasswordVisible,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.validate && !widget.isFieldValid)
          Container(
            padding: const EdgeInsets.only(top: 5.0, left: 20),
            child: Text(
              widget.label == 'Email'
              ? 'Please enter a valid email' 
              : widget.label == 'Password'
                ? 'Password must be at least 8 characters'
                : 'Invalid ${widget.label.toLowerCase()}', 
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
