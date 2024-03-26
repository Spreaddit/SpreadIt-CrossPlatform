import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/presentation/blocked_accounts_page.dart';
import 'package:spreadit_crossplatform/features/reset_password/presentation/pages/reset_password_main.dart';
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
import '../../data/data_source/api_basic_settings_data.dart';

/// The page for managing account settings.
class AccountSettingsPage extends StatefulWidget {
  /// Constructs an [AccountSettingsPage] instance.
  AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingsPage> createState() => AccountSettingsPageState();
}

/// [AccountSettingsPage] state.
class AccountSettingsPageState extends State<AccountSettingsPage> {
  /// Define the title of the page.
  final String title = "Account Settings";

  /// Variables to store user data.
  late Map<String, dynamic> data;
  String currentEmail = "";
  String currentLocation = "";

  /// Calls the [fetchData] method to fetch user information.
  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Fetches user data.
  Future<void> fetchData() async {
    // Call the function to retrieve basic user data.
    data = await getBasicData();
    // Update the state with the fetched data.
    setState(() {
      currentEmail = data["email"];
      currentLocation = data["country"];
    });
  }

  /// List of routes to navigate to different settings pages.
  final List<Widget> routes = [
    UpdateEmailPage(),
    ResetPassword(),
    SelectLocationPage(),
    NotificationsPageUI(),
    BlockedAccountsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    /// Lists to hold widgets for different sections of the settings page.
    List<Widget> basicSectionChildren = [];
    List<Widget> connectedSectionChildren = [];
    List<Widget> notificationsSectionChildren = [];
    List<Widget> safetySectionChildren = [];

    /// Function to navigate to a different page using a custom route transition.
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
        onPressed: () => Navigator.of(context)
            .pushNamed('/settings/account-settings/change-password'),
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
        onPressed: () => Navigator.of(context)
            .pushNamed('/settings/account-settings/manage-notifications'),
      ),
    ]);

    safetySectionChildren.addAll([
      ToPageBtn(
        iconData: Icons.block_outlined,
        mainText: "Manage blocked accounts",
        onPressed: () => Navigator.of(context)
            .pushNamed('/settings/account-settings/blocked_accounts'),
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
