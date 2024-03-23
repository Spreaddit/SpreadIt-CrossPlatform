import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/pages/blocked_accounts/blocked_accounts_page.dart';
import '../widgets/connected_acc_btn.dart';
import '../widgets/settings_followers_sect.dart';
import '../widgets/settings_gender_modal.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_btn_to_page.dart';
import '../widgets/settings_section_body.dart';
import '../widgets/settings_section_title.dart';
import 'update_email_page.dart';
import 'change_password_page.dart';
import 'location_select_page.dart';
import '../pages/manage_notifications_page.dart';
import '../data/data_source/api_basic_settings_data.dart';

class AccountSettingsPage extends StatefulWidget {
  AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final String title = "Account Settings";
  late Map<String, dynamic> data;
  String currentEmail = "";
  String currentLocation = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    data = await getBasicData(); // Await the result of getData()
    setState(() {
      currentEmail = data["email"];
      currentLocation = data["country"];
    });
  }

  final List<Widget> routes = [
    UpdateEmailPage(),
    ChangePasswordPage(),
    SelectLocationPage(),
    NotificationsPageUI(),
    BlockedAccountsPage(),
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
        secondaryText: currentEmail,
        onPressed: () async {
          await Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 200),
              reverseTransitionDuration: Duration(milliseconds: 100),
              pageBuilder: (_, __, ___) => routes[0],
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
          await fetchData();
        },
      ),
      ToPageBtn(
        iconData: Icons.settings_outlined,
        mainText: "Change password",
        onPressed: () => navigateToPage(routes[1]),
      ),
      ToPageBtn(
        iconData: Icons.location_on_outlined,
        mainText: "Location customization",
        secondaryText: currentLocation,
        tertiaryText:
            "Specify a location to customize your recommendations and feed. Reddit does not track your precise geolocation data. Learn more",
        onPressed: () async {
          await Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 200),
              reverseTransitionDuration: Duration(milliseconds: 100),
              pageBuilder: (_, __, ___) => routes[2],
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
          await fetchData();
        },
      ),
      SelectGender(),
    ]);

    connectedSectionChildren.addAll([
      ConnectAccBtn(
        iconData: Icons.account_circle_outlined,
        accountName: "Google",
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
        onPressed: () {},
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
