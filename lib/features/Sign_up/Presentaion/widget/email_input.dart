import 'package:flutter/material.dart';

class EmailInput extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool validate;
  final Function(String, bool) onEmailChanged;
  final String placeholder;
  bool isEmailValid;

  EmailInput({
    required this.formKey,
    required this.validate,
    required this.onEmailChanged,
    required this.isEmailValid,
    required this.placeholder,
  });

  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  late TextEditingController _controller;
  String email = '';
  

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        email = _controller.text;
        validateEmail(); 
      });
    });
  }

  void validateEmail() {
    if (widget.validate) {
      bool isValid =
          email.isNotEmpty && email.contains('@') && email.contains('.');
      setState(() {
        widget.isEmailValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: const EdgeInsets.only(
            top: 10,
            right: 20,
            left: 20,
            bottom: 10,
          ),
          color: Color(0xFFF5F5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Form(
              key: widget.formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: widget.placeholder,
                      border: InputBorder.none,
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                setState(() {
                                  _controller.clear();
                                  email = ''; 
                                  widget.onEmailChanged('',false);
                                  validateEmail(); 
                                });
                              },
                            )
                          : null,
                    ),
                    controller: _controller,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    onSaved: (value) {
                      email = value ?? ''; 
                      validateEmail(); 
                      widget.onEmailChanged(email,widget.isEmailValid);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.validate && !widget.isEmailValid)
          Container(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: const Text(
              'Not a valid email address',
              style: TextStyle(color: Color(0xFFFF4500)),
            ),
          ),
      ],
    );
  }
}
