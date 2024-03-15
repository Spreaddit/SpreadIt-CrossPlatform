import 'package:flutter/material.dart';
import 'widget/button.dart';
import 'widget/header.dart';
import 'widget/email_input.dart';
import 'widget/password_input.dart';
import 'widget/terms_and_cond_text.dart';


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
  var validEmail = true;
  var validPass = true;

  void navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed('/log-in-page');
  }

  void navigateToHomePage(BuildContext context) {
    final valid = _emailForm.currentState!.validate();
    final valid1 = _passwordForm.currentState!.validate();
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
      _validPassAndEmail = validEmail && validPass;
    });
    print('valid');
    print(_validPassAndEmail);
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
                    buttonText:'Log in',
                    title: 'Hi new friend, Welcome to SpreadIt',
                   onPressed: () => navigateToLogin(context),
                  ),
                  EmailInput(
                    formKey: _emailForm,
                    validate: true,
                    onEmailChanged: updateEmail,
                    isEmailValid: validEmail,
                    placeholder: 'Email'
                  ),
                  PasswordInput(
                    formKey: _passwordForm,
                    validate: true,
                    onPasswordChanged: updatePassword,
                    isPasswordValid: validPass,
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
             child : TermsAndCondText(), 
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
