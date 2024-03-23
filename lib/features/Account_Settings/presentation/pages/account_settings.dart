import 'package:flutter/material.dart';
import '../pages/dummy_page.dart';
import '../widgets/connected_acc_btn.dart';
import '../widgets/settings_followers_sect.dart';
import '../widgets/settings_gender_modal.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_btn_to_page.dart';
import '../widgets/settings_section_body.dart';
import '../widgets/settings_section_title.dart';
import '../pages/update_email.dart';
import '../pages/change_password.dart';
import '../pages/location_select.dart';
import '../pages/manage_notifications_page.dart';

void main() {
  runApp(const HomeAccountSettingsPage());
}

class HomeAccountSettingsPage extends StatefulWidget {
  const HomeAccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<HomeAccountSettingsPage> createState() =>
      _HomeAccountSettingsPageState();
}

class _HomeAccountSettingsPageState extends State<HomeAccountSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: AccountSettingsPage(),
    );
  }
}

class AccountSettingsPage extends StatefulWidget {
  AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final String title = "Account Settings";

  final List<Widget> routes = [
    UpdateEmailPage(),
    ChangePasswordPage(),
    SelectLocationPage(),
    NotificationsPageUI(),
    DummyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> basicSectionChildren = [];
    List<Widget> connectedSectionChildren = [];
    List<Widget> notificationsSectionChildren = [];
    List<Widget> safetySectionChildren = [];

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
        onPressed: () => navigateToPage(routes[1]),
      ),
      ToPageBtn(
        iconData: Icons.location_on_outlined,
        mainText: "Location customization",
        secondaryText: "Use approximate location (based on IP)",
        tertiaryText:
            "Specify a location to customize your recommendations and feed. Reddit does not track your precise geolocation data. Learn more",
        onPressed: () => navigateToPage(routes[2]),
      ),
      SelectGender(),
    ]);

    connectedSectionChildren.addAll([
      ConnectAccBtn(
        iconData: Icons.account_circle_outlined,
        accountName: "Google",
        onPressed: () {
          print("object");
        },
      )
    ]);

    notificationsSectionChildren.addAll([
      ToPageBtn(
        iconData: Icons.notifications_outlined,
        mainText: "Manage notifications",
        onPressed: () => navigateToPage(routes[3]),
      ),
    ]);

    safetySectionChildren.addAll([
      ToPageBtn(
        iconData: Icons.block_outlined,
        mainText: "Manage blocked accounts",
        onPressed: () => navigateToPage(routes[4]),
      ),
      ToPageBtn(
        iconData: Icons.volume_mute_outlined,
        mainText: "Manage muted communities",
        onPressed: () => navigateToPage(routes[4]),
      ),
      SwitchSection(),
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
              SettingsSectionTitle(title: "Connected Accounts"),
              SettingsSectionBody(sectionChildren: connectedSectionChildren),
              SettingsSectionTitle(title: "Contact Settings"),
              SettingsSectionBody(
                sectionChildren: notificationsSectionChildren,
              ),
              SettingsSectionTitle(title: "Safety"),
              SettingsSectionBody(
                sectionChildren: safetySectionChildren,
              ),
              SettingsSectionTitle(title: ""),
            ],
          ),
        ),
      ),
    );
  }
}
