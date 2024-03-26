import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_body.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_title.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/switch_type_2.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import '../../data/data_source/api_notifications_settings.dart';

/// Page for managing notification settings.
class NotificationsPageUI extends StatefulWidget {
  /// Constructs a [NotificationsPageUI] instance.
  const NotificationsPageUI({Key? key}) : super(key: key);
  @override
  State<NotificationsPageUI> createState() {
    return NotificationsPageUIState();
  }
}

/// [NotificationsPageUI] state.
class NotificationsPageUIState extends State<NotificationsPageUI> {
  /// List that hold the current notification settings, defaults to false.
  List<dynamic> notificationsSettingsList = List.generate(11, (_) => false);

  /// Calls the [fetchData] method to fetch user information.
  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Fetches notification settings data.
  Future<void> fetchData() async {
    var data = await getData(); // Await the result of getData()
    setState(() {
      notificationsSettingsList =
          data; // Update blockedAccountsList with fetched data
    });
  }

  /// Toggles the state of notification setting and calls the API to update the data.
  void stateSetter(int index) async {
    setState(() {
      notificationsSettingsList[index] = !notificationsSettingsList[index];
    });
    var result = await updateData(updatedList: notificationsSettingsList);
    if (result != 200) {
      setState(() {
        notificationsSettingsList[index] = !notificationsSettingsList[index];
      });
      CustomSnackbar(content: "Failed to update").show(context);
    }
  }

  @override
  Widget build(context) {
    /// A list of widgets representing the messages section in the notifications settings.
    List<Widget> messagesSection = [];

    /// A list of widgets representing the activity section in the notifications settings.
    List<Widget> activitySection = [];

    /// A list of widgets representing the updates section in the notifications settings.
    List<Widget> updatesSection = [];

    /// A list of widgets representing the moderation section in the notifications settings.
    List<Widget> moderationSection = [];

    messagesSection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.message_outlined,
        filledIconData: Icons.message,
        currentLightVal: notificationsSettingsList[0],
        mainText: "Private messages",
        onPressed: () {
          stateSetter(0);
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.sms_outlined,
        filledIconData: Icons.sms,
        currentLightVal: notificationsSettingsList[1],
        mainText: "Chat messages",
        onPressed: () {
          stateSetter(1);
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.maps_ugc_outlined,
        currentLightVal: notificationsSettingsList[2],
        filledIconData: Icons.maps_ugc,
        mainText: "Chat requests",
        onPressed: () {
          stateSetter(2);
        },
      ),
    ]);

    activitySection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.person_outlined,
        currentLightVal: notificationsSettingsList[3],
        filledIconData: Icons.person,
        mainText: "Mentions of u/username",
        onPressed: () {
          stateSetter(3);
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.chat_bubble_outline,
        currentLightVal: notificationsSettingsList[4],
        filledIconData: Icons.chat_bubble,
        mainText: "Comments on your posts",
        onPressed: () {
          stateSetter(4);
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.arrow_upward_outlined,
        currentLightVal: notificationsSettingsList[5],
        filledIconData: Icons.arrow_upward,
        mainText: "Upvotes on your posts",
        onPressed: () {
          stateSetter(5);
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.arrow_upward_outlined,
        currentLightVal: notificationsSettingsList[6],
        filledIconData: Icons.arrow_upward,
        mainText: "Upvotes on your comments",
        onPressed: () {
          stateSetter(6);
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.reply_outlined,
        currentLightVal: notificationsSettingsList[7],
        filledIconData: Icons.reply,
        mainText: "Replies to your comments",
        onPressed: () {
          stateSetter(7);
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.person_outlined,
        currentLightVal: notificationsSettingsList[8],
        filledIconData: Icons.person,
        mainText: "New followers",
        onPressed: () {
          stateSetter(8);
        },
      ),
    ]);

    updatesSection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.cake_outlined,
        currentLightVal: notificationsSettingsList[9],
        filledIconData: Icons.cake,
        mainText: "Cake day",
        onPressed: () {
          stateSetter(9);
        },
      ),
    ]);

    moderationSection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.shield_outlined,
        currentLightVal: notificationsSettingsList[10],
        filledIconData: Icons.shield,
        mainText: "Mod notifications",
        onPressed: () {
          stateSetter(10);
        },
      ),
    ]);

    return Scaffold(
      appBar: SettingsAppBar(
        title: "Notifications Settings",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SettingsSectionTitle(
                title: "Messages",
                textColor: Colors.black,
              ),
              SettingsSectionBody(sectionChildren: messagesSection),
              SettingsSectionTitle(
                title: "Activity",
                textColor: Colors.black,
              ),
              SettingsSectionBody(sectionChildren: activitySection),
              SettingsSectionTitle(
                title: "Updates",
                textColor: Colors.black,
              ),
              SettingsSectionBody(sectionChildren: updatesSection),
              SettingsSectionTitle(
                title: "Moderation",
                textColor: Colors.black,
              ),
              SettingsSectionBody(sectionChildren: moderationSection),
            ],
          ),
        ),
      ),
    );
  }
}
