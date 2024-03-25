import 'package:flutter/material.dart';

import '../../../generic_widgets/button.dart';
import '../../../generic_widgets/custom_input.dart';
import '../../../generic_widgets/header.dart';
import '../../../generic_widgets/terms_and_cond_text.dart';
import '../../../generic_widgets/validations.dart';
/// The sign-up screen where users can register with their email and password.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {

  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();
  
  var _userEmail = '';
  var _userPassword = '';
  bool _validPassAndEmail = false;
  var validEmail = false;
  var validPass = false;
  /// Navigates to the login page.

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/log-in-page');
  }

/// Navigates to the create username page after validating email and password.
  void navigateToCreateUsernamePage(BuildContext context) {
    if (validEmail && validPass) {
      _emailForm.currentState!.save();
      _passwordForm.currentState!.save();
      Navigator.of(context).pushNamed(
        '/create-username-page',
        arguments: {
          'email': _userEmail,
          'password': _userPassword,
        },
      );
    }
  }

/// Callback function to update the email and its validation status.
  void updateEmail(String email, bool validation) {
    _userEmail = email;
    validEmail = validation;
    _emailForm.currentState!.save();
    updateValidStatus();
  }

/// Callback function to update the password and its validation status.
  void updatePassword(String password, bool validation) {
    _userPassword = password;
    validPass = validation;
    _passwordForm.currentState!.save();
    updateValidStatus();
  }

/// Updates the validation status for both email and password.
  void updateValidStatus() {
    setState(() {
      _validPassAndEmail = validPass && validEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header(
                    buttonText: 'Log in',
                    title: 'Hi new friend, Welcome to SpreadIt',
                    onPressed: () => navigateToLogin(context),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  CustomInput(
                    formKey: _emailForm,
                    validate: true,
                    onChanged: updateEmail,
                    label: 'Email',
                    placeholder: 'Email',
                    invalidText: emailInvalidText,
                    validateField: validateEmail,
                  ),
                  CustomInput(
                    formKey: _passwordForm,
                    validate: true,
                    onChanged: updatePassword,
                    label: 'Password',
                    placeholder: 'Password',
                    obscureText: true,
                    invalidText: passwordInvalidText,
                    validateField: validatePassword,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TermsAndCondText(),
          ),
          Button(
            onPressed: () => navigateToCreateUsernamePage(context),
            text: 'Continue',
            backgroundColor:
                _validPassAndEmail ? Color(0xFFFF4500) : Color(0xFFEFEFED),
            foregroundColor: _validPassAndEmail
                ? Colors.white
                : Color.fromARGB(255, 113, 112, 112),
          ),
        ],
      ),
    );
  }
}