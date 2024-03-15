import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool validate;
  final Function(String, bool) onPasswordChanged;
  bool isPasswordValid;

  PasswordInput({
    required this.formKey,
    required this.validate,
    required this.onPasswordChanged,
    required this.isPasswordValid,
  });

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isPasswordVisible = false;
  late TextEditingController _controller;
  String password = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        password = _controller.text;
        validatePassword();
      });
    });
  }

  void validatePassword() {
    if (widget.validate) {
      bool isValid = password.isNotEmpty && password.length >= 8;

      setState(() {
        widget.isPasswordValid = isValid;
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
                      labelText: 'Password',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
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
                      ),
                    ),
                    controller: _controller,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !_isPasswordVisible,
                    onSaved: (value) {
                      password = value ?? '';
                      validatePassword();
                      widget.onPasswordChanged(password,widget.isPasswordValid);
                      validatePassword();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        if (widget.validate && !widget.isPasswordValid)
          Container(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: const Text(
              'Password must be at least 8 characters',
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
