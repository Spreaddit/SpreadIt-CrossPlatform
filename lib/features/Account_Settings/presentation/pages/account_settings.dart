import 'package:flutter/material.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_btn_to_page.dart';
import '../widgets/settings_section_body.dart';
import '../widgets/settings_section_title.dart';
import '../pages/dummy_page.dart';

void main() {
  runApp(const HomeAccountSettingsPage());
}

class HomeAccountSettingsPage extends StatelessWidget {
  const HomeAccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: AccountSettingsPage(),
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  AccountSettingsPage({Key? key}) : super(key: key);

  final String title = "Account Settings";

  final List<Widget> routes = [DummyPage()];

  @override
  Widget build(BuildContext context) {
    List<Widget> basicSectionChildren = [];
    List<Widget> notificationsSectionChildren = [];

    void navigateToPage(Widget route) {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 200),
          pageBuilder: (_, __, ___) => DummyPage(),
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
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

    basicSectionChildren.addAll([
      ToPageBtn(
        iconData: Icons.settings_outlined,
        mainText: "Update email address",
        secondaryText: "galalmohamed2003@gmail.com",
        onPressed: () => navigateToPage(routes[0]),
      ),
      ToPageBtn(
        iconData: Icons.settings_outlined,
        mainText: "Change password",
        onPressed: () => navigateToPage(routes[0]),
      ),
      ToPageBtn(
        iconData: Icons.location_on_outlined,
        mainText: "Location customization",
        secondaryText: "Use approximate location (based on IP)",
        tertiaryText:
            "Specify a location to customize your recommendations and feed. Reddit does not track your precise geolocation data. Learn more",
        onPressed: () => navigateToPage(routes[0]),
      ),
      ToPageBtn(
        iconData: Icons.person_outline,
        secondaryIconData: Icons.expand_more_outlined,
        mainText: "Gender",
        onPressed: () => print("Goto Set Gender"),
      )
    ]);

    notificationsSectionChildren.addAll([
      ToPageBtn(
        iconData: Icons.notifications_outlined,
        mainText: "Manage notifications",
        onPressed: () => navigateToPage(routes[0]),
      ),
      ToPageBtn(
        iconData: Icons.email_outlined,
        mainText: "Manage emails",
        onPressed: () => navigateToPage(routes[0]),
      ),
    ]);

    return Scaffold(
      backgroundColor: Color.fromARGB(237, 236, 236, 234),
      appBar: SettingsAppBar(
        title: title,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 228, 227, 227),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SettingsSectionTitle(
                title: "BASIC SETTINGS",
              ),
              SettingsSectionBody(
                sectionChildren: basicSectionChildren,
              ),
              SettingsSectionTitle(title: "Contact Settings"),
              SettingsSectionBody(
                  sectionChildren: notificationsSectionChildren),
            ],
          ),
        ),
      ),
    );
  }
}
