import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/account_settings_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_btn_to_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_body.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_title.dart';
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

  /// Represents the username associated with the fetched data.
  String username = "";

  /// Calls the [fetchData] method to fetch user information.
  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Fetches user information.
  Future<void> fetchData() async {
    data = await getUserInfo(); // Await the result of getData()
    setState(() {
      username = data["username"];
    });
  }

  @override
  Widget build(BuildContext context) {
    /// A list of widgets representing the general settings section in the settings page.
    List<Widget> generalSectionChildren = [];

    /// A list of widgets representing the feed options section in the settings page.
    List<Widget> feedOptionsSectionChildren = [];

    /// Navigates between pages with animation.
    void navigateToPage(Widget route) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 200),
          reverseTransitionDuration: Duration(milliseconds: 100),
          pageBuilder: (_, __, ___) => route,
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastOutSlowIn,
                ),
              ),
              child: child,
            );
          },
        ),
      );
    }

    generalSectionChildren.addAll([
      ToPageBtn(
        iconData: Icons.person_outline,
        mainText: "Account Settings for u/$username",
        onPressed: () =>
            Navigator.of(context).pushNamed('/settings/account-settings'),
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
