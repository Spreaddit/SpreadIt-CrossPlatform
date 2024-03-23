import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import '../data/data_source/api_verify_password_data.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import '../../../generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import 'package:spreadit_crossplatform/features/Sign_up/data/oauth_service.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import '../data/data_source/api_user_info_data.dart';

class ConfirmConnectedPassword extends StatefulWidget {
  const ConfirmConnectedPassword({
    Key? key,
    required this.connectionAction,
  }) : super(key: key);

  final String connectionAction;

  @override
  State<ConfirmConnectedPassword> createState() =>
      _ConfirmPasswConnectedordState();
}

class _ConfirmPasswConnectedordState extends State<ConfirmConnectedPassword> {
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();

  var _userPassword = '';

  late Map<String, dynamic> data;
  String currentEmail = "";
  String username = "";

  var validPass = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    data = await getUserInfo(); // Await the result of getData()
    setState(() {
      currentEmail = data["email"];
      username = data["username"];
    });
  }

  Future<void> navigateToForgetPassword(BuildContext context) async {
    /////////////////////////////////////////////////// changed when integrating cross ////////////////////////////////////////////////////
    bool signedIn = await signOutWithGoogle(context);
    if (signedIn) {
      Navigator.of(context).pushNamed('/start-up-page');
    }
  }

  void updatePassword(String password, bool validation) {
    _userPassword = password;
    validPass = validation;
    _passwordForm.currentState!.save();
  }

  void verifyConfirmPassword(BuildContext context) async {
    if (!validPass) {
      CustomSnackbar(content: "Enter a valid password").show(context);
      return;
    }
    _passwordForm.currentState!.save();
    var responseCode =
        await postData(enteredPassowrd: {"enteredPassword": _userPassword});
    if (responseCode == 0) {
      CustomSnackbar(content: "Error").show(context);
    } else if (responseCode == 401) {
      CustomSnackbar(content: "Current password is incorrect").show(context);
    } else if (responseCode == 500) {
      CustomSnackbar(content: "Internal server error").show(context);
    } else {
      CustomSnackbar(
              content:
                  "Succesfully ${widget.connectionAction.toLowerCase()}ed to your account")
          .show(context);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SettingsAppBar(
        title: "Confirm password",
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16, left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            foregroundImage: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "u/${username.toUpperCase()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                              ),
                              Text(
                                currentEmail,
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 25, 25, 25),
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Text(
                      "For your security, confirm ur password to finish ${widget.connectionAction.toLowerCase()}ing to ur account",
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomInput(
                      formKey: _passwordForm,
                      onChanged: updatePassword,
                      label: 'Reddit Password',
                      placeholder: 'Reddit Password',
                      obscureText: true,
                      validateField: validatePassword,
                      validate: true,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Button(
                    onPressed: () => Navigator.pop(context),
                    text: 'Cancel',
                    backgroundColor: const Color.fromARGB(255, 214, 214, 215),
                    foregroundColor: Colors.grey,
                  ),
                ),
                Expanded(
                  child: Button(
                    onPressed: () => verifyConfirmPassword(context),
                    text: 'Save',
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
