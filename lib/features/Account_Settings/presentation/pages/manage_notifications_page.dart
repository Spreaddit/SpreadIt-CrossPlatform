import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_body.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_title.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/switch_type_2.dart';

class NotificationsPageUI extends StatefulWidget {
  const NotificationsPageUI({Key? key}) : super(key: key);
  @override
  State<NotificationsPageUI> createState() {
    return _NotificationsPageUIState();
  }
}

class _NotificationsPageUIState extends State<NotificationsPageUI> {
  @override
  Widget build(context) {
    List<Widget> messagesSection = [];
    List<Widget> activitySection = [];
    List<Widget> updatesSection = [];
    List<Widget> moderationSection = [];

    /*
      Mentions
      Comments
      Upvotes to posts and comments
      Replies to comments
      New followers
      Cake day
      Mod notifications (reports to posts)
    */

    messagesSection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.message_outlined,
        filledIconData: Icons.message,
        mainText: "Private messages",
        onPressed: () {},
      ),
      SwitchBtn2(
        outlinedIconData: Icons.sms_outlined,
        filledIconData: Icons.sms,
        mainText: "Chat messages",
        onPressed: () {},
      ),
      SwitchBtn2(
        outlinedIconData: Icons.maps_ugc_outlined,
        filledIconData: Icons.maps_ugc,
        mainText: "Chat requests",
        onPressed: () {},
      ),
    ]);

    activitySection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.person_outlined,
        filledIconData: Icons.person,
        mainText: "Mentions of u/username",
        onPressed: () {},
      ),
      SwitchBtn2(
        outlinedIconData: Icons.chat_bubble_outline,
        filledIconData: Icons.chat_bubble,
        mainText: "Comments on your posts",
        onPressed: () {},
      ),
      SwitchBtn2(
        outlinedIconData: Icons.arrow_upward_outlined,
        filledIconData: Icons.arrow_upward,
        mainText: "Upvotes on your posts",
        onPressed: () {},
      ),
      SwitchBtn2(
        outlinedIconData: Icons.arrow_upward_outlined,
        filledIconData: Icons.arrow_upward,
        mainText: "Upvotes on your comments",
        onPressed: () {},
      ),
      SwitchBtn2(
        outlinedIconData: Icons.reply_outlined,
        filledIconData: Icons.reply,
        mainText: "Replies to your comments",
        onPressed: () {},
      ),
      SwitchBtn2(
        outlinedIconData: Icons.person_outlined,
        filledIconData: Icons.person,
        mainText: "New followers",
        onPressed: () {},
      ),
    ]);

    updatesSection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.cake_outlined,
        filledIconData: Icons.cake,
        mainText: "Cake day",
        onPressed: () {},
      ),
    ]);

    moderationSection.addAll([
      SwitchBtn2(
        outlinedIconData: Icons.shield_outlined,
        filledIconData: Icons.shield,
        mainText: "Mod notifications",
        onPressed: () {},
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
