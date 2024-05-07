import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_btn_to_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_body.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_title.dart';
import 'package:spreadit_crossplatform/features/dynamic_navigations/navigate_to_community.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import '../widgets/sort_home.dart';

/// A page where users can configure various settings.
class SettingsPage extends StatefulWidget {
  /// Constructs a [SettingsPage] instance.
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

/// [SettingsPage] state.
class _SettingsPageState extends State<SettingsPage> {
  /// Holds user data fetched.
  late Map<String, dynamic> data;

  /// Future that holds the user data fetched.
  late Future<Map<String, dynamic>> futureData;

  /// A list of widgets representing the general settings section in the settings page.
  List<Widget> generalSectionChildren = [];

  /// A list of widgets representing the feed options section in the settings page.
  List<Widget> feedOptionsSectionChildren = [];

  /// Calls the [fetchData] method to fetch user information.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    generalSectionChildren.addAll([
      ToPageBtn(
        iconData: Icons.person_outline,
        mainText: "Account Settings for u/${UserSingleton().user!.username}",
        onPressed: () =>
            Navigator.of(context).pushNamed('/settings/account-settings'),
      ),
      ToPageBtn(
        iconData: Icons.shield_rounded,
        mainText: "GalalModCommunity2", //"RehabCom",
        onPressed: () => navigateToCommunity(context, "GalalModCommunity2"),
      ),
    ]);

    feedOptionsSectionChildren.addAll([
      SortHome(),
    ]);

    return Scaffold(
      appBar: SettingsAppBar(title: "Settings"),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 228, 227, 227),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsSectionTitle(title: "General"),
              SettingsSectionBody(sectionChildren: generalSectionChildren),
              SettingsSectionTitle(title: "Feed Options"),
              SettingsSectionBody(sectionChildren: feedOptionsSectionChildren),
              SettingsSectionTitle(title: ""),
            ],
          ),
        ),
      ),
    );
  }
}
