import 'package:flutter/material.dart';

import '../../../generic_widgets/button.dart';
import '../../../generic_widgets/custom_input.dart';
import '../../../generic_widgets/header.dart';
import '../../../generic_widgets/snackbar.dart';
import '../../../generic_widgets/terms_and_cond_text.dart';
import '../../data/log_in_api.dart';
/// The login screen where users can enter their username and password to log in.
class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  LogInScreenState createState() => LogInScreenState();
}

class LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _usernameForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();

  var _username = '';
  var _userPassword = '';
  bool _validPassAndUsername = false;
  var validusername = true;
  var validPass = true;

    /// Navigates to the forget password page.
  void navigateToForgetPassword(BuildContext context) {
    Navigator.of(context).pushNamed('/forget-password');
  }

  /// Navigates to the forget username page.
  void navigateToForgetUsername(BuildContext context) {
    Navigator.of(context).pushNamed('/forget-username');
  }

/// Navigates to the sign-up page.
  void navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed('/sign-up-page');
  }

/// Navigates to the home page after successful login.
  void navigateToHomePage(BuildContext context) async {
    if (validusername && validPass) {
      _usernameForm.currentState!.save();
      _passwordForm.currentState!.save();
    }
    var responseCode = await logInApi(
      username: _username,
      password: _userPassword,
    );
    if (responseCode == 200) {
      Navigator.of(context).pushNamed('/home'); 
    } else if (responseCode == 400) {
      CustomSnackbar(content: "Invalid input").show(context);
    } else if (responseCode == 404) {
      CustomSnackbar(content: "User not found").show(context);
    } else if (responseCode == 401) {
      CustomSnackbar(content: "Authentication failed").show(context);
    }
  }

/// Callback function to update the username and its validation status.
  void updateUsername(String username, bool validation) {
    _username = username;
    validusername = validation;
    _usernameForm.currentState!.save();
    updateValidStatus();
  }

/// Callback function to update the password and its validation status.
  void updatePassword(String password, bool validation) {
    _userPassword = password;
    validPass = validation;
    _passwordForm.currentState!.save();
    updateValidStatus();
  }

/// Updates the validation status for both username and password.
  void updateValidStatus() {
    setState(() {
      _validPassAndUsername = _username.isNotEmpty && _userPassword.isNotEmpty;
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  CustomInput(
                    formKey: _usernameForm,
                    onChanged: updateUsername,
                    label: 'Username',
                    placeholder: 'Username',
                  ),
                  CustomInput(
                    formKey: _passwordForm,
                    onChanged: updatePassword,
                    label: 'Password',
                    placeholder: 'Password',
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Container(
                        margin: const EdgeInsets.all(20),
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: () => navigateToForgetUsername(context),
                          child: Text(
                            'Forgot Username?',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFF4500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
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
          Button(
            onPressed: () => navigateToHomePage(context),
            text: 'Continue',
            backgroundColor:
                _validPassAndUsername ? Color(0xFFFF4500) : Color(0xFFEFEFED),
            foregroundColor: _validPassAndUsername
                ? Colors.white
                : Color.fromARGB(255, 113, 112, 112),
          ),
        ],
      ),
    );
  }
}