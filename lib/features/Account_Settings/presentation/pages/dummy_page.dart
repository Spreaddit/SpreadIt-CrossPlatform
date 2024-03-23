import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(
        title: "DUMMY PAGE",
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Useless Button, Use the AppBar Icon To Return'),
        ),
      ),
    );
  }
}
