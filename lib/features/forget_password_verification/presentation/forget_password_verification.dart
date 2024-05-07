import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/widgets/reset_password_validations.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import '../../generic_widgets/button.dart';
import '../../generic_widgets/custom_input.dart';
import '../../generic_widgets/header.dart';
import '../../generic_widgets/validations.dart';
import '../data/send_passwords.dart';
import '../../Account_Settings/presentation/pages/verify_email.dart';

/// This class is responsible for rendering the [ForgetPasswordVerification] page.
/// It contains an input field in which a user writes his `emailOrUsername` and a button to send this input data to the backend.


class ForgetPasswordVerification extends StatefulWidget {
  const ForgetPasswordVerification({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordVerification> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPasswordVerification> {

  final GlobalKey<FormState> _newPasswordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmedPasswordForm = GlobalKey<FormState>();

  String _newPassword = '';
  String _confirmedPassword = '';
  bool isValidInput = false ;

  @override
  void initState() {
    super.initState();
    print('verification initialized');
    getVerificationToken();
  }

  Future<void> getVerificationToken() async {
    try {
      String currentUrl = Uri.base.toString();
      final List<String> parts = currentUrl.split('/');
      final String token = parts.last;
      print("token $token");
      await verifyEmail(emailToken: token);
    }
    catch(e) {
      print('error while getting current URL: $e');
    }
  }

  void updateNewPassword(String password, bool validation) {
    _newPassword = password;
    isValidInput = validation;
    _newPasswordForm.currentState!.save();
    setState(() => {isValidInput = validation});
  }

  void updateConfirmedPassword(String password, bool validation) {
    _confirmedPassword = password;
    isValidInput = validation;
    _confirmedPasswordForm.currentState!.save();
    setState(() => {isValidInput = validation});
  }

  void checkNotEmpty(){
    if(validateNotEmpty(_newPassword) && validateNotEmpty(_confirmedPassword)){
      if(checkIdentical(_newPassword, _confirmedPassword)) {
        postData();
      }
      else {
        CustomSnackbar(content:"password mismatch:please reconfirm your new password").show(context);
      }
    }
    else {
      CustomSnackbar(content: "please fill both text fields").show(context);
    }
  }

  void postData() async{
    int response =  await sendPasswords(_newPassword);
    if (response == 200){
      CustomSnackbar(content: "password updated successfully").show(context);
      UserSingleton().clearUserFromPrefs();
      UserSingleton().user = null; // Clear user info
      Navigator.pushNamedAndRemoveUntil(context, '/api/login', (route) => false);
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
              title: "Reset password",
              onPressed: () {}), 
          ),
          Container(
            child: CustomInput(
              formKey: _newPasswordForm,
              onChanged: updateNewPassword,
              label: "New password",
              placeholder: "New password",
              obscureText: true,
            ),
          ),
          Container(
            child: CustomInput(
              formKey: _confirmedPasswordForm,
              onChanged: updateConfirmedPassword,
              label: "Confirmed password",
              placeholder: "Confirmed password",
              obscureText: true,
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
          ),
        ],
        ),
    );
  }
}







