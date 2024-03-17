import 'package:flutter/material.dart';
import 'widget/button.dart';
import 'widget/header.dart';
import 'widget/terms_and_cond_text.dart';
import 'widget/custom_input.dart'; 
import 'widget/validations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();
  var _userEmail = '';  // to be sent to api
  var _userPassword = ''; // to be sent to api
  bool _validPassAndEmail = false;
  var validEmail = false;
  var validPass = false;

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/log-in-page');
  }

  void navigateToHomePage(BuildContext context) {
    if (validEmail && validPass) {
      _emailForm.currentState!.save();
      _passwordForm.currentState!.save();
      Navigator.of(context).pushNamed('/sign-up-page'); // change later
    }
  }

  void updateEmail(String email, bool validation) {
    _userEmail = email;
    validEmail = validation;
    _emailForm.currentState!.save();
    updateValidStatus();
  }

  void updatePassword(String password, bool validation) {
    _userPassword = password;
    validPass = validation;
    _passwordForm.currentState!.save();
    updateValidStatus();
  }

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
                  CustomInput(
                    formKey: _emailForm,
                    validate: true,
                    onChanged: updateEmail,
                    isFieldValid: validEmail,
                    label: 'Email',
                    placeholder: 'Email',
                    invalidText: emailInvalidText,
                    validateField:validateEmail,
                  ),
                  CustomInput(
                    formKey: _passwordForm,
                    validate: true,
                    onChanged: updatePassword,
                    isFieldValid: validPass,
                    label: 'Password',
                    placeholder: 'Password',
                    obscureText: true,
                    invalidText: passwordInvalidText,
                    validateField:validatePassword,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 16,
              left: 20,
              right: 20,
            ),
            child: TermsAndCondText(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.bottomCenter,
            child: Button(
              onPressed: () => navigateToHomePage(context),
              text: 'Continue',
              backgroundColor: _validPassAndEmail
                  ? Color(0xFFFF4500)
                  : Color(0xFFEFEFED),
              foregroundColor: _validPassAndEmail
                  ? Colors.white
                  : Color.fromARGB(255, 113, 112, 112),
            ),
          ),
        ],
      ),
    );
  }
}
