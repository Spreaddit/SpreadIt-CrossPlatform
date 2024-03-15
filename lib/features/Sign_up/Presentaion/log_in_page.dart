import 'package:flutter/material.dart';
import 'widget/button.dart';
import 'widget/header.dart';
import 'widget/email_input.dart';
import 'widget/password_input.dart';
import 'widget/terms_and_cond_text.dart';
import "./widget/oauth_service.dart";


class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();

  var _userEmail = '';
  var _userPassword = '';
  bool _validPassAndEmail = false;
  var validEmail = true;
  var validPass = true;

  void navigateToForgetPassword(BuildContext context) {
    signOutWithGoogle( context) ;   // change later
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed('/sign-up-page'); 
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
                    buttonText:  'Sign up' ,
                    title: 'Log in to Spreadit',
                    onPressed: () => navigateToSignUp(context), 
                  ),
                  EmailInput(
                    formKey: _emailForm,
                    validate: false,
                    onEmailChanged: updateEmail,
                    isEmailValid: validEmail,
                    placeholder: 'Email or Username'
                  ),
                  PasswordInput(
                    formKey: _passwordForm,
                    validate: false,
                    onPasswordChanged: updatePassword,
                    isPasswordValid: validPass,
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.topLeft,
                    child:  TextButton(
                            onPressed: () => navigateToForgetPassword(context), 
                            child: Text(
                              'Forgot Password?',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFFFF4500),
                              ),
                            ),
                          )
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
