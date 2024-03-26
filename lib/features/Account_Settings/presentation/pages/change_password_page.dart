import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Sign_up/data/oauth_service.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/validations.dart';
import '../../data/data_source/api_user_info_data.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_input.dart';
import '../../../generic_widgets/snackbar.dart';
import '../../data/data_source/api_verify_password_data.dart';

/// A page for changing the user's password.
class ChangePasswordPage extends StatefulWidget {
  /// Constructs an [ChangePasswordPage] instance.
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}
/// [ChangePasswordPage] state.
class _ChangePasswordPageState extends State<ChangePasswordPage> {
  /// Global keys for managing form states.
  final GlobalKey<FormState> _currentPasswordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _newPasswordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmNewPasswordForm = GlobalKey<FormState>();

  /// Variables to hold user input for passwords.
  var _currentUserPassword = '';
  var _newUserPassword = '';
  var _confirmNewUserPassword = '';

  /// Data to store user information fetched from API.
  late Map<String, dynamic> data;

  /// Username of the user.
  String username = "";

  /// Flag to indicate the validity of password change process.
  var _validState = false;

  /// Flag to indicate the validity of the current password.
  var validCurrentPass = false;

  /// Flag to indicate the validity of the new password.
  var validNewPass = false;

  /// Flag to indicate the validity of the confirm new password.
  var validConfirmNewPass = false;

  /// Fetches user data during initialization.
  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Calls the [fetchData] method to fetch user information.
  Future<void> fetchData() async {
    data = await getUserInfo(); // Await the result of getData()
    setState(() {
      username = data["username"];
    });
  }

  /// Navigates to the forget password page.
  void navigateToForgetPassword(BuildContext context) {
    Navigator.of(context).pushNamed('/forget-password');
  }

  /// Updates the current password field.
  void updateCurrentPassword(String password, bool validation) {
    _currentUserPassword = password;
    validCurrentPass = validation;
    _currentPasswordForm.currentState!.save();
    updateValidStatus();
  }

  /// Updates the new password field.
  void updateNewPassword(String password, bool validation) {
    _newUserPassword = password;
    validNewPass = validation;
    _newPasswordForm.currentState!.save();
    updateValidStatus();
  }

  /// Updates the confirm new password field.
  void updateConfirmNewPassword(String password, bool validation) {
    _confirmNewUserPassword = password;
    validConfirmNewPass = validation;
    _confirmNewPasswordForm.currentState!.save();
    updateValidStatus();
  }

  /// Updates the valid state based on password validations.
  void updateValidStatus() {
    setState(() {
      _validState = _newUserPassword == _confirmNewUserPassword &&
          _newUserPassword.isNotEmpty &&
          _newUserPassword.length >= 8;
    });
  }

  /// Verifies and updates the user's password.
  void verifyPasswordUpdate(BuildContext context) async {
    if (_currentUserPassword.isEmpty || _currentUserPassword.length < 8) {
      CustomSnackbar(content: "Enter valid current password").show(context);
      return;
    }
    if (!_validState) {
      CustomSnackbar(content: "Invalid new password data").show(context);
      return;
    }
    _newPasswordForm.currentState!.save();
    var responseCode = await postData(
        enteredPassowrd: {"enteredPassword": _currentUserPassword});
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
        title: "Change password",
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
                            ],
                          )
                        ],
                      ),
                    ),
                    CustomInput(
                      formKey: _currentPasswordForm,
                      onChanged: updateCurrentPassword,
                      label: 'Current Password',
                      placeholder: 'Current Password',
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
                    CustomInput(
                      formKey: _newPasswordForm,
                      onChanged: updateNewPassword,
                      label: 'New Password',
                      placeholder: 'New Password',
                      obscureText: true,
                      validateField: validatePassword,
                      validate: true,
                    ),
                    CustomInput(
                      formKey: _confirmNewPasswordForm,
                      onChanged: updateConfirmNewPassword,
                      label: 'Confirm New Password',
                      placeholder: 'Confirm New Password',
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
                    onPressed: () => verifyPasswordUpdate(context),
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
