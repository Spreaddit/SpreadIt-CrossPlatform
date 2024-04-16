import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/data/data_source/api_basic_settings_data.dart';
import 'package:spreadit_crossplatform/features/Sign_up/Presentaion/pages/start_up_page.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import '../../../reset_password/data/update_password.dart';
import '../../data/data_source/api_user_info_data.dart';
import '../../../reset_password/presentation/widgets/reset_password_validations.dart';
import '../../../generic_widgets/custom_input.dart';
import '../../../generic_widgets/header.dart';

/// This class renders the [AddPasswordPage] page.
/// It displays 2 input fields where the user writes his `newPassword` and `confirmedPassword`.
/// It also contains a button `Continue` that the user presses to send his input to the backend.
class AddPasswordPage extends StatefulWidget {
  const AddPasswordPage({Key? key}) : super(key: key);

  @override
  State<AddPasswordPage> createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final GlobalKey<FormState> _newPasswordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmedPasswordForm = GlobalKey<FormState>();

  /// Data fetched from user information API.
  late Map<String, dynamic> basicData;

  String username = "";
  String _newPassword = '';
  String _confirmedPassword = '';
  String _token = 'dummy_token';

  bool isValidInput = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Fetches user information.
  Future<void> fetchData() async {
    var data = await getUserInfo();
    setState(() {
      username = data["username"];
    });
    basicData = await getBasicData();
  }

  /// Updates the new password with the provided [password] and [validation] status.
  ///
  /// This method is called when the user wants to update their password in the account settings.
  /// The [password] parameter represents the new password entered by the user.
  /// The [validation] parameter indicates whether the password meets the required validation criteria.
  void updateNewPassword(String password, bool validation) {
    _newPassword = password;
    setState(() {
      isValidInput = validation;
    });
    _newPasswordForm.currentState!.save();
  }

  /// Updates the confirmed password with the given [password] and [validation] status.
  ///
  /// This method is called when the user enters a password and the validation status
  /// is updated. It updates the confirmed password field with the entered password
  /// and updates the validation status accordingly.
  ///
  /// Parameters:
  /// - [password]: The entered password.
  /// - [validation]: The validation status of the entered password.
  void updateConfirmedPassword(String password, bool validation) {
    _confirmedPassword = password;
    setState(() {
      isValidInput = validation;
    });
    _confirmedPasswordForm.currentState!.save();
  }

  bool textValidations() {
    if (checkPasswordLength(_newPassword, _newPassword, _confirmedPassword)) {
      if (checkIdentical(_newPassword, _confirmedPassword)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  /// Sends a POST request to the server with the data.
  void postData() async {
    int response = await updatePassword(_newPassword, "", _token);
    if (response == 200) {
      basicData["email"] = basicData["connectedAccounts"][0];
      var result = await updateBasicData(updatedData: basicData);
      if (result != 1) {
        CustomSnackbar(content: "Failed to update password").show(context);
      } else {
        CustomSnackbar(content: "password is updated successfully")
            .show(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => StartUpPage()),
            (_) => false);
      }
    } else if (response == 400) {
      CustomSnackbar(
              content:
                  "entered password is not the current password , please provide the correct password")
          .show(context);
    } else if (response == 401) {
      CustomSnackbar(content: "an error occurred , please refill correct data")
          .show(context);
    } else if (response == 500) {
      CustomSnackbar(
              content: "a server error occurred , please try again later")
          .show(context);
    } else {
      CustomSnackbar(content: "invalid data").show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Header(
                      title: "Choose a new password",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Reset your password for $username",
                      style: TextStyle(
                        fontSize: 17.5,
                        color: Colors.black87,
                      ),
                    ),
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
                ],
              ),
            ),
          ),
          Text(
            "Resetting your password will log you out on all devices.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          Button(
            onPressed: textValidations() ? () => postData() : null,
            text: 'Continue',
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
