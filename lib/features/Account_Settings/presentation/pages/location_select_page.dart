import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/data/data_source/api_user_info_data.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import '../data/data_source/api_basic_settings_data.dart';

class SelectLocationPage extends StatelessWidget {
  SelectLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> availableLocations = [
      "Use approximate location (based on IP)",
      "No location specified",
      "Afghanistan",
      "Egypt",
      "Germany",
      "UK",
      "USA",
    ];

    return Scaffold(
      appBar: SettingsAppBar(
        title: "Select location",
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 10),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: availableLocations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(availableLocations[index]),
            onTap: () async{
              var data = await getBasicData();
              data["country"] = availableLocations[index];
              var result = await updateUserInfo(updatedData: data);
              if (result == 0) CustomSnackbar(content: "Failed to update location").show(context);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
