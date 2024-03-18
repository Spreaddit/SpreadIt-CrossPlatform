import 'package:flutter/material.dart';
import '../widgets/generic/button.dart';
import '../widgets/generic/custom_input.dart';
import '../widgets/generic/header.dart';
import '../widgets/generic/validations.dart';
import '../widgets/generic/reset_password_widgets/user_card.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _currentPasswordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _newPasswordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmedPasswordForm = GlobalKey<FormState>();


  String _currentPassword = '';
  String _newPassword = '';
  String _confirmedPassword = '';

  bool isValidInput = false ;
  bool areIdentical = false ;

  void updateCurrentPassword(String password, bool validation) {
    _currentPassword = password;
    isValidInput = validation;
    _currentPasswordForm.currentState!.save();
  }

  void updateNewPassword(String password, bool validation) {
    _newPassword = password;
    isValidInput = validation;
    _newPasswordForm.currentState!.save();
  }

  void updateConfirmedPassword(String password, bool validation) {
    _confirmedPassword = password;
    isValidInput = validation;
    _confirmedPasswordForm.currentState!.save();
  }

  void NavigateToForgetPassword(){
     Navigator.of(context).pushNamed('/forgetPasswordPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Header(
              buttonText: "Save",
              title: "Reset Password",
              onPressed: () {}),
          ),
          Container(
            margin: EdgeInsets.all(10) ,
            child: UserCard()  ,
          ),
          Container(
            child: CustomInput(
              formKey: _currentPasswordForm,
              onChanged: updateCurrentPassword ,
              label:"" ,
              placeholder: "Current password",
              obscureText: true,),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 20, 5),
            alignment: Alignment.centerRight,
            child: InkWell(
              child: Text(" Forgot password"),
              onTap: NavigateToForgetPassword ,
            ),
          ),
          Container(
            child: CustomInput(
              formKey: _newPasswordForm,
              onChanged: updateNewPassword ,
              label:"" ,
              placeholder: "Current password",
              obscureText: true,),
          ),
          Container(
            child: CustomInput(
              formKey: _confirmedPasswordForm,
              onChanged: updateConfirmedPassword ,
              label:"" ,
              placeholder: "Current password",
              obscureText: true,),
          ),
        ],
        ),
    );
  }
}

/* TO DOs:
1) afham men mimo el buttons wel input fields shaghalin ezzay (leih el placeholder msh zaher ml awwel)
2) azawwed el visibility 
3) ashouf 7war el button elli lono sabet da 
4) navigation (done for this page)
5) unit testing 
6) desktop or web
7) mock service  */
