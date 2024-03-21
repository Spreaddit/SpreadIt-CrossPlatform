import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(
        title: "Change password",
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Welcome to the Change Password Page'),
        ),
      ),
    );
  }
}
