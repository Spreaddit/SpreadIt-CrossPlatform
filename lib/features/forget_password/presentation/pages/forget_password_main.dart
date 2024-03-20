import 'package:flutter/material.dart';
import '../widgets/generic/button.dart';
import '../widgets/generic/custom_input.dart';
import '../widgets/generic/header.dart';
import '../widgets/generic/validations.dart';
import '../../data/send_user_input.dart';
import '../widgets/generic/snackbar.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final GlobalKey<FormState> _inputForm = GlobalKey<FormState>();

  String _usernameOrEmail = '';
  bool isValidInput = false ;

  void updateInput(String input, bool validation) {
    _usernameOrEmail = input;
    isValidInput = validation;
    _inputForm.currentState!.save();
  }

  void checkUserInput() async{
    Future<bool> response = sendUserInput(_usernameOrEmail);
    if (await response){
      CustomSnackbar(content: "an email was sent to you to reset your password").show(context);
    }
    else{
      CustomSnackbar(content: "an error occured , please enter email again").show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Header(
              buttonText: "Help",
              title: "Forgot password?",
              onPressed: () {}),
          ),
          Container(
            margin: EdgeInsets.all(10) ,
            child: Text(
              "Enter your email address or username and we'll send you a link to reset your password",
              style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54
              ),
            ),  
          ),
          Container(
            child: CustomInput(
              formKey: _inputForm,
              onChanged: updateInput ,
              label:"Email or username" ,
              placeholder: "Email or username",
              invalidText:"invalid username or mail",
              validateField: validateNotEmpty,
              validate: true,
            ),
          ),
          Spacer(),
          Container(
            child: Button(
              onPressed: checkUserInput,
              text: "Reset Password",
              backgroundColor:  isValidInput ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight,
              foregroundColor: Colors.white,
            ),
          )
        ],
        ),
    );
  }
}

/* TO DOs:

1) el zorar lono msh byetghayyar
2) navigation 
3) unit testing 
4) mock service (done but double check)
5) username masmou7 kaman walla laa(law laa change variable name and) */

/*
elvalidation elli fl text field hey a just text validation , el mafroud a3mel function zyada lamma adous 3al zorar teb3at el 
usernmae or password lel back w howwa nycheck law el mail aw el username dol actually 3al database */