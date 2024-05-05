import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/data/data_source/api_allow_follow_data.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/connected_acc_only_dialog.dart';
import '../widgets/connected_acc_btn.dart';
import '../widgets/settings_followers_sect.dart';
import '../widgets/settings_gender_modal.dart';
import '../widgets/settings_app_bar.dart';
import '../widgets/settings_btn_to_page.dart';
import '../widgets/settings_section_body.dart';
import '../widgets/settings_section_title.dart';
import '../../data/data_source/api_basic_settings_data.dart';

/// The page for managing account settings.
class AccountSettingsPage extends StatefulWidget {
  /// Constructs an [AccountSettingsPage] instance.
  AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

/// [AccountSettingsPage] state.
class _AccountSettingsPageState extends State<AccountSettingsPage> {
  /// Define the title of the page.
  final String title = "Account Settings";

  /// Variables to store user data.
  late Map<String, dynamic> basicData;

  /// Future that holds the user data fetched.
  late Future<Map<String, dynamic>> futureBasicData;

  /// Variables to store user follower settings data.
  late Map<String, dynamic> followSettingsData;

  /// Future that holds the user follower settings data fetched.
  late Future<Map<String, dynamic>> futureFollowSettingsData;

  /// Lists to hold widgets for different sections of the settings page.
  List<Widget> basicSectionChildren = [];
  List<Widget> connectedSectionChildren = [];
  List<Widget> notificationsSectionChildren = [];
  List<Widget> safetySectionChildren = [];

  String currentEmail = "";
  String currentLocation = "";
  bool connectedAccOnly = false;

  /// Calls the [fetchData] method to fetch user information.
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  bool isInit = false;

  /// Fetches user data.
  Future<void> fetchData() async {
    // Call the function to retrieve basic user data.
    futureBasicData = getBasicData().then((value) {
      basicData = value;
      currentEmail = basicData["email"];
      connectedAccMode();
      currentLocation = (basicData["country"] == "IP")
          ? "Use approximate location (based on IP)"
          : basicData["country"];
      if (mounted) {
        setState(() {});
      }
      return value;
    });
    futureFollowSettingsData = getFollowersSettingsData().then((value) {
      followSettingsData = value;
      return value;
    });
  }

  /// Modifies the page according to whether the user is connected using a connected account only or not.
  void connectedAccMode() {
    if (currentEmail == "") {
      connectedAccOnly = true;
      currentEmail = basicData["connectedAccounts"][0];
    } else {
      connectedAccOnly = false;
    }
  }

  /// Setup widgets for all sections of the settings page.
  void setupPageSections() {
    basicSectionChildren = [
      ToPageBtn(
        iconData: Icons.settings_outlined,
        mainText: "Update email address",
        secondaryText: currentEmail,
        onPressed: () {
          if (connectedAccOnly) {
            ConnectedAccountOnlyDialog(context, 0, currentEmail);
          } else {
            Navigator.of(context)
                .pushNamed('/settings/account-settings/update-email')
                .then((_) => fetchData());
          }
        },
      ),
      ToPageBtn(
        iconData: Icons.settings_outlined,
        mainText: (connectedAccOnly) ? "Add password" : "Change password",
        onPressed: () {
          if (connectedAccOnly) {
            ConnectedAccountOnlyDialog(context, 1, currentEmail);
          } else {
            Navigator.of(context)
                .pushNamed('/settings/account-settings/change-password');
          }
        },
      ),
      ToPageBtn(
        iconData: Icons.location_on_outlined,
        mainText: "Location customization",
        secondaryText: currentLocation,
        tertiaryText:
            "Specify a location to customize your recommendations and feed. Reddit does not track your precise geolocation data. Learn more",
        onPressed: () {
          Navigator.of(context)
              .pushNamed('/settings/account-settings/location-select')
              .then((_) => fetchData());
        },
      ),
      SelectGender(
        basicData: basicData,
      ),
    ];

    connectedSectionChildren = [
      ConnectAccBtn(
        iconData: Icons.account_circle_outlined,
        accountName: "Google",
        basicData: basicData,
      )
    ];

    notificationsSectionChildren = [
      ToPageBtn(
        iconData: Icons.notifications_outlined,
        mainText: "Manage notifications",
        onPressed: () => Navigator.of(context)
            .pushNamed('/settings/account-settings/manage-notifications'),
      ),
    ];

    safetySectionChildren = [
      ToPageBtn(
        iconData: Icons.block_outlined,
        mainText: "Manage blocked accounts",
        onPressed: () => Navigator.of(context)
            .pushNamed('/settings/account-settings/blocked_accounts'),
      ),
      ToPageBtn(
        iconData: Icons.volume_mute_outlined,
        mainText: "Manage muted communities",
        onPressed:  () => Navigator.of(context)
            .pushNamed('/muted-commuinties'),
      ),
      FollowersSwitchSection(allowFollow: followSettingsData["allowFollow"]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(237, 236, 236, 234),
      appBar: SettingsAppBar(
        title: title,
      ),
      body: FutureBuilder(
        future: Future.wait([futureBasicData, futureFollowSettingsData]),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.deepOrangeAccent,
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error occurred while fetching data 😢');
          } else if (snapshot.hasData) {
            setupPageSections();
            return SingleChildScrollView(
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
                    SettingsSectionBody(
                        sectionChildren: connectedSectionChildren),
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
            );
          } else {
            return Text('Uknown error occurred while fetching data 🤔');
          }
        }),
      ),
    );
  }
}
