import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import '../../data/data_source/api_verify_password_data.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import '../../../generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import '../../data/data_source/api_user_info_data.dart';

/// Page for confirming the account's password.
///
/// Used for verification when connecting or disconnecting from the connected accounts experience.
class ConfirmConnectedPassword extends StatefulWidget {
  /// Constructs an [ConfirmConnectedPassword] instance.
  /// 
  /// Parameters:
  /// - [connectionAction] : [String] Specifies whether the user is connecting or disconnecting [required].
  const ConfirmConnectedPassword({
    Key? key,
    required this.connectionAction,
  }) : super(key: key);

  final String connectionAction;

  @override
  State<ConfirmConnectedPassword> createState() =>
      _ConfirmPasswConnectedordState();
}

/// [ConfirmConnectedPassword] state.
class _ConfirmPasswConnectedordState extends State<ConfirmConnectedPassword> {
  /// Entered password form state variable.
  final GlobalKey<FormState> _passwordForm = GlobalKey<FormState>();

  /// Variable for storing the entered password.
  var _userPassword = '';

  /// Variable for storing user data.
  late Map<String, dynamic> data;

  /// The current email associated with the user.
  String currentEmail = "";

  /// The username of the user.
  String username = "";

  /// Flag indicating whether the entered password is valid.
  var validPass = false;

  /// Calls the [fetchData] method to fetch user information.
  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Fetches user information.
  Future<void> fetchData() async {
    data = await getUserInfo(); // Await the result of getData()
    setState(() {
      currentEmail = data["email"];
      username = data["username"];
    });
  }

  /// Navigates to the forget password page.
  void navigateToForgetPassword(BuildContext context) {
    Navigator.of(context).pushNamed('/forget-password');
  }

  /// Updates the password field.
  void updatePassword(String password, bool validation) {
    _userPassword = password;
    validPass = validation;
    _passwordForm.currentState!.save();
  }

  /// Verifies the confirmation of the password.
  void verifyConfirmPassword(BuildContext context) async {
    if (!validPass) {
      CustomSnackbar(content: "Enter a valid password").show(context);
      return;
    }
    _passwordForm.currentState!.save();
    var responseCode =
        await verfiyPasswordData(enteredPassowrd: {"enteredPassword": _userPassword});
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
