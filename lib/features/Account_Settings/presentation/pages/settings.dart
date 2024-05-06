import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_btn_to_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_body.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_title.dart';
import 'package:spreadit_crossplatform/features/dynamic_navigations/navigate_to_community.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import '../../data/data_source/api_user_info_data.dart';
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
    fetchData();
  }

  /// Fetches user information.
  Future<void> fetchData() async {
    futureData = getUserInfo().then((value) {
      data = value;
      generalSectionChildren.addAll([
        ToPageBtn(
          iconData: Icons.person_outline,
          mainText: "Account Settings for u/${data["username"]}",
          onPressed: () =>
              Navigator.of(context).pushNamed('/settings/account-settings'),
        ),
        ToPageBtn(
          iconData: Icons.shield_rounded,
          mainText: "RehabCom",
          onPressed: () => navigateToCommunity(context, "RehabCom"),
        ),
      ]);
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    feedOptionsSectionChildren.addAll([
      SortHome(),
    ]);

    return Scaffold(
      appBar: SettingsAppBar(title: "Settings"),
      body: FutureBuilder(
        future: futureData,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoaderWidget(
                dotSize: 10.0,
                logoSize: 100.0,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error occurred while fetching data 😢');
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Container(
                color: Color.fromARGB(255, 228, 227, 227),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingsSectionTitle(title: "General"),
                    SettingsSectionBody(
                        sectionChildren: generalSectionChildren),
                    SettingsSectionTitle(title: "Feed Options"),
                    SettingsSectionBody(
                        sectionChildren: feedOptionsSectionChildren),
                    SettingsSectionTitle(title: ""),
                  ],
                ),
              ),
            );
          } else {
            return Text('Uknown error occurred while fetching data 🤔');
          }
        }),
      ),
    );
  }
}
