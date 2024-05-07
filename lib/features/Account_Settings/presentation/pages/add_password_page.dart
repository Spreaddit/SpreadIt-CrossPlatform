import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/data/data_source/api_add_password.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/data/data_source/api_verify_email_data.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import '../../../reset_password/presentation/widgets/reset_password_validations.dart';
import '../../../generic_widgets/custom_input.dart';
import '../../../generic_widgets/header.dart';

/// This class renders the [AddPasswordPage] page.
/// It displays 2 input fields where the user writes his `newPassword` and `confirmedPassword`.
/// It also contains a button `Continue` that the user presses to send his input to the backend.
class AddPasswordPage extends StatefulWidget {
  AddPasswordPage({Key? key}) : super(key: key);

  @override
  State<AddPasswordPage> createState() => _AddPasswordPageState();
}

class _AddPasswordPageState extends State<AddPasswordPage> {
  final GlobalKey<FormState> _newPasswordForm = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmedPasswordForm = GlobalKey<FormState>();

  String username = "";
  String _newPassword = '';
  String _confirmedPassword = '';

  bool isValidInput = false;
  String? currentRoute;
  bool isDone = false;
  String emailToken = "";
  @override
  void initState() {
    super.initState();
    username = UserSingleton().user!.username;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isDone) {
      isDone = true;
      Future.delayed(Duration.zero, () {
        final currentRoute = ModalRoute.of(context)?.settings.name;
        final List<String> pathSegments = currentRoute!.split('/');
        emailToken = pathSegments[pathSegments.length - 1];
        checkEmailToken(emailToken);
      });
    }
  }

  void checkEmailToken(String emailToken) async {
    var verificationResponse = await verifyEmail(emailToken: emailToken);
    if (verificationResponse == 200) {
      CustomSnackbar(content: "Email verification success").show(context);
    } else {
      print("Email verification failed");
      CustomSnackbar(content: "Email verification failed").show(context);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      Navigator.pushNamed(context, '/settings');
      Navigator.pushNamed(context, '/settings/account-settings');
    }
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
  /// - [password] : The entered password.
  /// - [validation] : The validation status of the entered password.
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
  void addNewPassword() async {
    int response = await addPasswordRequest(password: _newPassword);
    if (response == 200) {
      CustomSnackbar(content: "Password added successfully").show(context);
      Navigator.pushNamedAndRemoveUntil(
          context, '/start-up-page', (_) => false);
    } else if (response == 404) {
      CustomSnackbar(
              content:
                  "User not found, please try again later or contact support")
          .show(context);
    } else if (response == 500) {
      CustomSnackbar(
              content: "A server error occurred , please try again later")
          .show(context);
    } else {
      CustomSnackbar(content: "Invalid data").show(context);
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
                  Header(
                    title: "Choose a new password",
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
                  CustomInput(
                    formKey: _newPasswordForm,
                    onChanged: updateNewPassword,
                    label: "New password",
                    placeholder: "New password",
                    obscureText: true,
                  ),
                  CustomInput(
                    formKey: _confirmedPasswordForm,
                    onChanged: updateConfirmedPassword,
                    label: "Confirmed password",
                    placeholder: "Confirmed password",
                    obscureText: true,
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
            onPressed: textValidations() ? () => addNewPassword() : null,
            text: 'Continue',
            backgroundColor: Colors.deepOrangeAccent,
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
