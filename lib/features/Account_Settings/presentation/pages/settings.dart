import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/pages/account_settings_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_btn_to_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_body.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_title.dart';
import '../data/data_source/api_user_info_data.dart';
import '../widgets/sort_home.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Map<String, dynamic> data;
  String username = "";

  var validPass = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    data = await getData(); // Await the result of getData()
    setState(() {
      username = data["username"];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> generalSectionChildren = [];
    List<Widget> feedOptionsSectionChildren = [];

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
        onPressed: () => navigateToPage(AccountSettingsPage()),
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
