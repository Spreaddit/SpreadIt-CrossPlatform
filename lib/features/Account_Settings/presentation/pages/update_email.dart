import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';

class UpdateEmailPage extends StatelessWidget {
  const UpdateEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(
        title: "Update email address",
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Welcome to the Update Email Address Page'),
        ),
      ),
    );
  }
}
