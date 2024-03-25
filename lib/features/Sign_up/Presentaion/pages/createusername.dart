import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/header.dart';
import 'package:spreadit_crossplatform/features/Sign_up/data/sign_up_api.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import '../../../generic_widgets/snackbar.dart';

/// This page allows users to create their usernames during the sign-up process.
class CreateUsername extends StatefulWidget {
  const CreateUsername({Key? key}) : super(key: key);

  @override
  State<CreateUsername> createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername> {
  final GlobalKey<FormState> _usernameFormKey = GlobalKey<FormState>();

  late String _userName;
  late String _userEmail;
  late String _userPassword;
  late bool validUserName;
  late String invalidText;

  @override
  void initState() {
    super.initState();
    _userName = '';
    validUserName = true;
    invalidText = '';
  }

  /// Callback function to update the username and its validation status.
  void updateUsername(String username, bool validation) {
    setState(() {
      _userName = username;
      invalidText = validateusernametext(_userName);
      validUserName = validation && invalidText == "Great name! it's not taken, so it's all yours.";
    });
    _usernameFormKey.currentState!.save();
  }

  /// Navigates to the home page after successful sign-up.
  void navigateToHomePage(BuildContext context) async {
    if (validUserName) {
      _usernameFormKey.currentState!.save();
      var responseCode = await signUpApi(
        username: _userName,
        email: _userEmail,
        password: _userPassword,
      );
      if (responseCode == 200) {
        Navigator.of(context).pushNamed('/home'); 
      } else if (responseCode == 400) {
        CustomSnackbar(content: "Invalid input").show(context); 
      } else if (responseCode == 409) {
        CustomSnackbar(content: "User already exists").show(context); 
      } 
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _userEmail = args['email'];
    _userPassword = args['password'];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Header(
                    title: 'Create your username',
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Most spreadditos use an anonymous username\nYou won't be able to change it later",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomInput(
                    formKey: _usernameFormKey,
                    onChanged: updateUsername,
                    label: 'Username',
                    placeholder: 'Username',
                    validateField: validateusername,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5.0, left: 25, right: 25),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      invalidText,
                      style: TextStyle(
                        color: validUserName ? Colors.green : Colors.red,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Button(
            onPressed: () => navigateToHomePage(context),
            text: 'Continue',
            backgroundColor: validUserName ? Color(0xFFFF4500) : Color(0xFFEFEFED),
            foregroundColor: validUserName ? Colors.white : Color.fromARGB(255, 113, 112, 112),
          ),
        ],
      ),
    );
  }
}
