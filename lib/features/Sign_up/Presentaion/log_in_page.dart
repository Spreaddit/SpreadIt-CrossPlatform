import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'widget/button.dart';
import 'widget/header.dart';
import 'widget/terms_and_cond_text.dart';
import "./widget/oauth_service.dart";
import 'widget/custom_input.dart'; 
import "./auth.dart";

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();
  var _userEmail = ''; // passeed later to api
  var _userPassword = ''; // passed later to api
  bool _validPassAndEmail = false;
  var validEmail = true;
  var validPass = true;

 
  Future<void> navigateToForgetPassword(BuildContext context) async {
    //changed later 
    bool signedIn= await signOutWithGoogle(context); 
  if(signedIn) {
    Navigator.of(context).pushNamed('/start-up-page'); 
  }
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed('/sign-up-page');
  }

  

  void navigateToHomePage(BuildContext context){
    if (validEmail && validPass) {
      _emailForm.currentState!.save();
      _passwordForm.currentState!.save();
    }
    //navigate here
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
      _validPassAndEmail = _userEmail.isNotEmpty && _userPassword.isNotEmpty;
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
                    buttonText: 'Sign up',
                    title: 'Log in to Spreadit',
                    onPressed: () => navigateToSignUp(context),
                  ),
                  CustomInput(
                    formKey: _emailForm,
                    onChanged: updateEmail,
                    label: 'Email',
                    placeholder: 'Email or Username',
                  ),
                  CustomInput(
                    formKey: _passwordForm,
                    onChanged: updatePassword,
                    label: 'Password',
                    placeholder: 'Password',
                    obscureText: true,
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () => navigateToForgetPassword(context),
                      child: Text(
                        'Forgot Password?',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFFFF4500),
                        ),
                      ),
                    ),
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
