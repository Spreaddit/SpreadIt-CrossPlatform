import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Sign_up/Presentaion/widget/button.dart';
import 'package:spreadit_crossplatform/features/Sign_up/Presentaion/widget/custom_input.dart';
import 'package:spreadit_crossplatform/features/Sign_up/Presentaion/widget/header.dart';
import 'package:spreadit_crossplatform/features/Sign_up/Presentaion/widget/validations.dart';

class CreateUsername extends StatefulWidget {
  const CreateUsername({Key? key}) : super(key: key);

  @override
  State<CreateUsername> createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername> {
  final GlobalKey<FormState> _usernameform = GlobalKey<FormState>();

  var _userName = ''; // passed later to api
  var validUserName = true;
  var invalidText = "";

  void updateUsername(String username, bool validation) {
    _userName = username;
    setState(() {
      invalidText = validateusernametext(_userName);
      validUserName = validation && invalidText == "Great name! it's not taken, so it's all yours.";
    });
    _usernameform.currentState!.save();
  }

  void navigateToHomePage(BuildContext context) async {
    if (validUserName) {
      _usernameform.currentState!.save();
      // Navigate to homepage
    } else {
      // msh 3rfa ha show snackbar wla la lesa
    }
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
                    title: 'Log in to Spreadit',
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top:20,
                      left:30,
                      right:30,
                      bottom:20,
                    ),
                     alignment: Alignment.center,
                    child: Text(
                      "Most spreadditos use an anonymous username\nYou won't be able to change it later",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  CustomInput(
                    formKey: _usernameform,
                    onChanged: updateUsername,
                    label: 'Username',
                    placeholder: 'Username',
                    validateField: validateusername,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 5.0, left: 25), 
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.bottomCenter,
            child: Button(
              onPressed: () => navigateToHomePage(context),
              text: 'Continue',
              backgroundColor: validUserName
                  ? Color(0xFFFF4500)
                  : Color(0xFFEFEFED),
              foregroundColor: validUserName
                  ? Colors.white
                  : Color.fromARGB(255, 113, 112, 112),
            ),
          ),
        ],
      ),
    );
  }
}
