import 'package:flutter/material.dart';

/// A customizable input field widget.
/// This widget provides a flexible input field that can be customized in various ways,
/// including text, password, and validation support.
/// Required parameters:
/// -formKey: A global key used to identify the form that contains this input field.
/// -onChanged: A callback function triggered whenever the input field value changes.
/// -label: The label text displayed above the input field.
/// -placeholder: The placeholder text displayed inside the input field when it's empty.
/// Optional parameters:
/// -obscureText: Determines whether the input should be obscured (e.g., for passwords). Defaults is set to false.
/// -invalidText: The text to display when input validation fails.
/// -validateField: A function used to validate the input field's value. Returns true if valid, false otherwise.
/// -validate: Indicates whether input validation is enabled. Defaults is set to false.
/// ```dart
///   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
///   var _inputvalue = '';   // The value inside the input feild
///    void updateInput(String value, bool isValid) {
///     _inputvalue = value;
///     isFeildValid = isValid;
///     _formkey.currentState!.save();
///     }
/// CustomInput(
///   formKey: _formKey,
///   onChanged: updateInput, 
///   label: 'Email',
///   placeholder: 'Enter your email',
///   obscureText: false,
///   invalidText: 'Please enter a valid email',
///   validateField: (value) {
///     return EmailValidator.validate(value); 
///   },
///   validate: true,
/// )
/// ```

class CustomInput extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String, bool) onChanged;
  final String label;
  final String placeholder;
  final bool obscureText;
  final String invalidText;
  final String? initialBody;
  final bool Function(String)? validateField;
  final bool validate;
  final double? height;
  final String? tertiaryText;
  final int? wordLimit;
  final Color backgroundColor;

  CustomInput({
    required this.formKey,
    required this.onChanged,
    required this.label,
    required this.placeholder,
    this.obscureText = false,
    this.invalidText = "",
    this.validateField,
    this.validate = false,
    this.height,
    this.tertiaryText,
    this.wordLimit,
    this.backgroundColor = const Color.fromARGB(255, 251, 251, 251),
    this.initialBody,
  });

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  late TextEditingController _controller;
  bool _isPasswordVisible = false;
  bool _isValid = true;
  late FocusNode _focusNode;
  bool _isFocused = true;
  late int _remainingCharacters;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialBody);
    _controller.addListener(_textChangedListener);
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    
    // Calculate remaining characters initially
    if (widget.wordLimit != null) {
      _remainingCharacters = widget.wordLimit! - _controller.text.length;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _textChangedListener() {
    setState(() {
      if (widget.validate) {
        _isValid = widget.validateField!(_controller.text);
      }
      widget.onChanged(_controller.text, _isValid);

      // Update remaining characters
      if (widget.wordLimit != null) {
        _remainingCharacters = widget.wordLimit! - _controller.text.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget inputField = Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: widget.validate
              ? _isFocused
                  ? Colors.transparent
                  : _isValid
                      ? const Color.fromARGB(255, 107, 188, 110)
                      : const Color.fromARGB(255, 233, 88, 77)
              : Colors.transparent,
          width: 1.0,
        ),
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                TextFormField(
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    labelText: widget.label,
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color.fromARGB(255, 85, 80, 80)),
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
                                  });
                                },
                              )
                            : null),
                  ),
                  controller: _controller,
                  obscureText: widget.obscureText && !_isPasswordVisible,
                  maxLines: widget.obscureText? 1:null, // Allow multiple lines
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (widget.height != null) {
      inputField = SizedBox.fromSize(
        size: Size.fromHeight(widget.height!),
        child: inputField,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        inputField,
        if (widget.validate && !_isValid)
          Container(
            padding: const EdgeInsets.only(top: 5.0, left: 25),
            child: Text(
              widget.invalidText,
              style: TextStyle(color: Colors.red),
            ),
          ),
        if (widget.tertiaryText != null || widget.wordLimit != null)
          Container(
            padding: const EdgeInsets.only(top: 5.0, left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.tertiaryText != null)
                  Flexible(
                    child: Text(
                      widget.tertiaryText!,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                if (widget.tertiaryText == null)
                  SizedBox(width: screenWidth * 0.6),
                if (widget.wordLimit != null)
                  Text(
                    ' $_remainingCharacters',
                    style: TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
