import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Sign_up/data/oauth_service.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import '../data/data_source/api_user_info_data.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import '../../../generic_widgets/snackbar.dart';
import '../data/data_source/api_verify_password_data.dart';

class UpdateEmailPage extends StatefulWidget {
  const UpdateEmailPage({Key? key}) : super(key: key);

  @override
  State<UpdateEmailPage> createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  final GlobalKey<FormState> _emailForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();

  var _userEmail = '';
  var _userPassword = '';

  late Map<String, dynamic> data;
  String currentEmail = "";
  String username = "";

  var _validPassAndEmail = false;
  var validEmail = false;
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

  void updateEmail(String useremail, bool validation) {
    _userEmail = useremail;
    validEmail = validation;
    _emailForm.currentState!.save();
    updateValidStatus();
  }

  void updatePassword(String password, bool validation) {
    _userPassword = password;
    validPass = validation;
    _passwordForm.currentState!.save();
    updateValidStatus();
  }

  void updateValidStatus() {
    setState(() {
      _validPassAndEmail = _userEmail.isNotEmpty && _userPassword.isNotEmpty;
    });
  }

  void verifyEmailUpdate(BuildContext context) async {
    if (!validEmail) {
      CustomSnackbar(content: "Enter a valid email").show(context);
      return;
    }
    if (!validPass) {
      CustomSnackbar(content: "Enter a valid password").show(context);
      return;
    }
    _emailForm.currentState!.save();
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
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: SettingsAppBar(
        title: "Update email address",
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
                      padding: EdgeInsets.only(bottom: 16, left: 20),
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
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    CustomInput(
                      formKey: _emailForm,
                      onChanged: updateEmail,
                      label: 'New email address',
                      placeholder: 'New email address',
                      validateField: validateEmail,
                      validate: true,
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
                    Container(
                      margin: const EdgeInsets.all(20),
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: () => navigateToForgetPassword(context),
                        child: Text(
                          'Forgot Password?',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF4500),
                          ),
                        ),
                      ),
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
                    onPressed: () => verifyEmailUpdate(context),
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
