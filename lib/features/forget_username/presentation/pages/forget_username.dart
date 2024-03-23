import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import '../../../generic_widgets/button.dart';
import '../../../generic_widgets/custom_input.dart';
import '../../../generic_widgets/header.dart';
import '../../../generic_widgets/validations.dart';
import '../../data/post_email.dart';

class ForgetUsername extends StatefulWidget {
  const ForgetUsername({Key? key}) : super(key: key);

  @override
  State<ForgetUsername> createState() => _ForgetUsernameState();
}

class _ForgetUsernameState extends State<ForgetUsername> {
  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();

  String _email = '';
  bool isValidEmail = false;

  void updateEmail(String email, bool validation) {
    _email = email;
    setState(() => {isValidEmail = validation});
    _emailForm.currentState!.save();
  }

  void postEmail() async {
    if (validateEmail(_email)) {
      int response = await sendEmail(_email);
      if (response == 200) {
        CustomSnackbar(content: "Your username was sent to your email")
            .show(context);
      } else {
        CustomSnackbar(
                content:
                    "An internal server error has occured , please try again later")
            .show(context);
      }
    } else {
      CustomSnackbar(content: "please enter a valid email").show(context);
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
                title: "Forgot username?",
                onPressed: () {}),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "Tell us the email address associated with your SpreadIt account, and we'll send you an email with your username",
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ),
          Container(
            child: CustomInput(
              formKey: _emailForm,
              onChanged: updateEmail,
              label: "Email address",
              placeholder: "Email address",
            ),
          ),
          Spacer(),
          Container(
            child: Button(
              onPressed: postEmail,
              text: "Email me",
              backgroundColor: isValidEmail ? Color(0xFFFF4500) : Colors.grey,
              foregroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
