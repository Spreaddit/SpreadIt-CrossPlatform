import 'package:flutter/material.dart';
import '../widgets/generic/button.dart';
import '../widgets/generic/custom_input.dart';
import '../widgets/generic/header.dart';
import '../widgets/generic/validations.dart';
import '../widgets/generic/reset_password_widgets/user_card.dart';
import '../widgets/generic/snackbar.dart';
import '../../data/update_password.dart';

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

  bool isValidInput = false;
  

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
  
  bool checkCurrentPassExists(){
    if(_currentPassword.isNotEmpty ){
     checkPasswordLength();
     return true; 
    }
    else {
     CustomSnackbar(content: "provide your current password" ).show(context); 
     return false;
    }
  }
  
  bool checkPasswordLength() {
    if (_newPassword.length < 8 || _confirmedPassword.length < 8) {
        CustomSnackbar(content: "password must contain more than 8 characters").show(context);
        return false;   
    }
    else {
      checkIdentical();
      return true;
    }
  }

  bool checkIdentical() {
    if (_newPassword != _confirmedPassword){
      CustomSnackbar(content: "password mismatch:please reconfirm your new password").show(context);
      return false;
      }
    else{
      postData();
      return true;
    }  
  }

  void postData() async{
      Future<bool> response = UpdatePassword(_currentPassword, _newPassword);
      if( await response) {
        CustomSnackbar(content: "password is updated successfully").show(context);
      }
      else {
        CustomSnackbar(content: " an error occurred , please refill correct data").show(context);
      }
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
              onPressed: checkCurrentPassExists),
          ),
          Container(
            margin: EdgeInsets.all(10) ,
            child: UserCard()  ,
          ),
          Container(
            child: CustomInput(
              formKey: _currentPasswordForm,
              onChanged: updateCurrentPassword ,
              label:"Current password" ,
              placeholder: "Current password",
              invalidText: "provide your current password",
              validateField: validatePassword,
              validate: true,
              obscureText: true,),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 20, 5),
            alignment: Alignment.centerRight,
            child: InkWell(
              child: Text("Forgot password"),
              onTap: checkCurrentPassExists ,
            ),
          ),
          Container(
            child: CustomInput(
              formKey: _newPasswordForm,
              onChanged: updateNewPassword ,
              label:"New password" ,
              placeholder: "New password",
              obscureText: true,),
          ),
          Container(
            child: CustomInput(
              formKey: _confirmedPasswordForm,
              onChanged: updateConfirmedPassword ,
              label:"Confirmed password" ,
              placeholder: "Confirmed password",
              obscureText: true,),
          ), 
        ],
        ),
    );
  }
}

/* TO DOs:
1) el custom snackbar shaghal bas el save bta3et mimo laa (check with mimo again)  
4) unit testing 
5) mock service
  a) lamma adous save a check el current password di matching walla laa , law laa talla3i snack bar
  b) law matching yeshil el old password w ybaddelha bl gedida w ytalla3 snack bar enno done 
  c) yegib el username wel email wel avatar ml database  */
