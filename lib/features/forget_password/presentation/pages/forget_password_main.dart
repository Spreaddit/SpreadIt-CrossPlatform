import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import '../../../generic_widgets/button.dart';
import '../../../generic_widgets/custom_input.dart';
import '../../../generic_widgets/header.dart';
import '../../../generic_widgets/validations.dart';
import '../../data/send_user_input.dart';

/// This class is responsible for rendering the [ForgetPassword] page.
/// It contains an input field in which a user writes his `emailOrUsername` and a button to send this input data to the backend.


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
      CustomSnackbar(content: "please enter your email or username").show(context);
    }
  }

  void checkUserInput() async{
    int response =  await sendUserInput(_usernameOrEmail);
    if (response == 200){
      CustomSnackbar(content: "an email was sent to you to reset your password").show(context);
    }
    else if (response == 400){
      CustomSnackbar(content: "please enter your email or username").show(context);
    }
    else if (response == 500){
      CustomSnackbar(content: "an internal server error has occured , please try again later").show(context);
    }
    else {
      CustomSnackbar(content:" no username exists").show(context);
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
              onPressed: () {}), //TODO: to be implemented later
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
              backgroundColor:  isValidInput ? Color(0xFFFF4500) : Colors.grey,
              foregroundColor: Colors.white,
            ),
          )
        ],
        ),
    );
  }
}


