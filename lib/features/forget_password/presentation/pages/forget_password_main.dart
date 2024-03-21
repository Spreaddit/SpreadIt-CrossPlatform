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
     setState(() => {isValidInput = validation});
    _inputForm.currentState!.save();
  }

  void checkNotEmpty(){
    if(validateNotEmpty(_usernameOrEmail)){
      checkUserInput();
    }
    else {
      CustomSnackbar(content: "please provide your email").show(context);
    }
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
              onPressed: checkNotEmpty,
              text: "Reset Password",
              backgroundColor:  isValidInput ? Colors.orange : Colors.grey,
              foregroundColor: Colors.white,
            ),
          )
        ],
        ),
    );
  }
}

/* TO DOs:

1) el zorar lono msh byetghayyar ( moshkela fl theme colors)
2) navigation 
3) unit testing */
