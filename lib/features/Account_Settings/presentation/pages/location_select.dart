import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';

class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(
        title: "Select location",
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Welcome to the Select location page'),
        ),
      ),
    );
  }
}
