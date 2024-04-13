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
    return _NotificationsPageUIState();
  }
}

/// [NotificationsPageUI] state.
class _NotificationsPageUIState extends State<NotificationsPageUI> {
  /// List that hold the current notification settings, defaults to false.
  List<dynamic> notificationsSettingsList = List.generate(11, (_) => false);

  Map<String, dynamic> notificationsSettingsValues = {
    "newFollowers": false,
    "mentions": false,
    "inboxMessages": false,
    "chatMessages": false,
    "chatRequests": false,
    "repliesToComments": false,
    "cakeDay": false,
    "modNotifications": false,
    "commentsOnYourPost": false,
    "commentsYouFollow": false,
    "upvotes": false
  };

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
      notificationsSettingsValues =
          data;
    });
  }

  /// Toggles the state of notification setting and calls the API to update the data.
  void stateSetter(String key) async {
    setState(() {
      notificationsSettingsValues[key] = !notificationsSettingsValues[key];
    });
    print("Updated notifics: $notificationsSettingsValues");
    var result = await updateData(updatedNotificationsSettings: notificationsSettingsValues);
    if (result != 200) {
      setState(() {
        notificationsSettingsValues[key] = !notificationsSettingsValues[key];
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
        currentLightVal: notificationsSettingsValues["inboxMessages"],
        mainText: "Private messages",
        onPressed: () {
          stateSetter("inboxMessages");
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.sms_outlined,
        filledIconData: Icons.sms,
        currentLightVal: notificationsSettingsValues["chatMessages"],
        mainText: "Chat messages",
        onPressed: () {
          stateSetter("chatMessages");
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.maps_ugc_outlined,
        currentLightVal: notificationsSettingsValues["chatRequests"],
        filledIconData: Icons.maps_ugc,
        mainText: "Chat requests",
        onPressed: () {
          stateSetter("chatRequests");
        },
      ),
    ]);

    activitySection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.person_outlined,
        currentLightVal: notificationsSettingsValues["mentions"],
        filledIconData: Icons.person,
        mainText: "Mentions of u/username",
        onPressed: () {
          stateSetter("mentions");
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.chat_bubble_outline,
        currentLightVal: notificationsSettingsValues["commentsOnYourPost"],
        filledIconData: Icons.chat_bubble,
        mainText: "Comments on your posts",
        onPressed: () {
          stateSetter("commentsOnYourPost");
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.arrow_upward_outlined,
        currentLightVal: notificationsSettingsValues["commentsYouFollow"],
        filledIconData: Icons.arrow_upward,
        mainText: "Upvotes on your posts",
        onPressed: () {
          stateSetter("commentsYouFollow");
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.arrow_upward_outlined,
        currentLightVal: notificationsSettingsValues["upvotes"],
        filledIconData: Icons.arrow_upward,
        mainText: "Upvotes on your comments",
        onPressed: () {
          stateSetter("upvotes");
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.reply_outlined,
        currentLightVal: notificationsSettingsValues["repliesToComments"],
        filledIconData: Icons.reply,
        mainText: "Replies to your comments",
        onPressed: () {
          stateSetter("repliesToComments");
        },
      ),
      SwitchBtn2(
        outlinedIconData: Icons.person_outlined,
        currentLightVal: notificationsSettingsValues["newFollowers"],
        filledIconData: Icons.person,
        mainText: "New followers",
        onPressed: () {
          stateSetter("newFollowers");
        },
      ),
    ]);

    updatesSection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.cake_outlined,
        currentLightVal: notificationsSettingsValues["cakeDay"],
        filledIconData: Icons.cake,
        mainText: "Cake day",
        onPressed: () {
          stateSetter("cakeDay");
        },
      ),
    ]);

    moderationSection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.shield_outlined,
        currentLightVal: notificationsSettingsValues["modNotifications"],
        filledIconData: Icons.shield,
        mainText: "Mod notifications",
        onPressed: () {
          stateSetter("modNotifications");
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
