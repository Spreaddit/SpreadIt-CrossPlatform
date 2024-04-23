import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_btn_to_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_body.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_title.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/dummy_page.dart';

class ModtoolsPage extends StatelessWidget {
  ModtoolsPage({Key? key}) : super(key: key);

  /// List of routes to navigate to different modtools sub-pages.
  final Map<String, Widget> routes = {
    "description_page": DummyPage(),
    "community_type_page": DummyPage(),
    "post_types_page": DummyPage(),
    "discovery_page": DummyPage(),
    "scheduled_posts_page": DummyPage(),
    "moderators_page": DummyPage(),
    "approved_users_page": DummyPage(),
    "banned_users_page": DummyPage(),
  };

  @override
  Widget build(BuildContext context) {
    /// Lists to hold widgets for different sections of the modtools.
    List<Widget> generalSection = [];
    List<Widget> contentAndRegulationsSection = [];
    List<Widget> userManagementSection = [];

    /// Function to navigate to a different page using a custom route transition.
    void navigateToPage(Widget? route) {
      if (route == null) {
        return;
      }
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

    generalSection.addAll([
      ToPageBtn(
        iconData: Icons.edit_outlined,
        mainText: "Description",
        onPressed: () => navigateToPage(routes["description_page"]),
      ),
      ToPageBtn(
        iconData: Icons.lock_outlined,
        mainText: "Community type",
        onPressed: () => navigateToPage(routes["community_type_page"]),
      ),
      ToPageBtn(
        iconData: Icons.article_outlined,
        mainText: "Post types",
        onPressed: () => navigateToPage(routes["post_types_page-"]),
      ),
      ToPageBtn(
        iconData: Icons.explore_outlined,
        mainText: "Discovery",
        onPressed: () => navigateToPage(routes["discovery_page"]),
      ),
      ToPageBtn(
        iconData: Icons.local_offer_outlined,
        mainText: "Content Tags",
        onPressed: () => DummyPage(),
      ),
    ]);

    contentAndRegulationsSection.addAll([
      ToPageBtn(
        iconData: Icons.schedule_outlined,
        mainText: "Scheduled posts",
        onPressed: () => navigateToPage(routes["scheduled_posts_page"]),
      ),
    ]);

    userManagementSection.addAll([
      ToPageBtn(
        iconData: Icons.shield_outlined,
        mainText: "Moderators",
        onPressed: () => navigateToPage(routes["moderators_page"]),
      ),
      ToPageBtn(
        iconData: Icons.person_outlined,
        mainText: "Approved users",
        onPressed: () => navigateToPage(routes["approved_users_page"]),
      ),
      ToPageBtn(
        iconData: Icons.hardware_outlined,
        mainText: "Banned users",
        onPressed: () => navigateToPage(routes["banned_users_page"]),
      ),
    ]);

    return Scaffold(
      appBar: SettingsAppBar(
        title: "Moderator tools",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingsSectionTitle(title: "General"),
            SettingsSectionBody(sectionChildren: generalSection),
            SettingsSectionTitle(title: "Content & Regulations"),
            SettingsSectionBody(sectionChildren: contentAndRegulationsSection),
            SettingsSectionTitle(title: "User Management"),
            SettingsSectionBody(sectionChildren: userManagementSection),
            SettingsSectionTitle(title: ""),
          ],
        ),
      ),
    );
  }
}
