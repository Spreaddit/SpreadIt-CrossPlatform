import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_btn_to_page.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_body.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_section_title.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/moderators-page.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_moderators_data.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/approved_users_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/banned_users_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/community_type_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/description_page.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/dummy_page.dart';
import 'package:spreadit_crossplatform/features/post_types_moderation/presentation/pages/post_types_page.dart';
import 'package:spreadit_crossplatform/user_info.dart';

class ModtoolsPage extends StatefulWidget {
  ModtoolsPage({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

  @override
  State<ModtoolsPage> createState() => _ModtoolsPageState();
}

class _ModtoolsPageState extends State<ModtoolsPage> {
  /// Lists to hold widgets for different sections of the modtools.
  final List<Widget> generalSection = [];

  final List<Widget> contentAndRegulationsSection = [];

  final List<Widget> userManagementSection = [];

  /// List of routes to navigate to different modtools sub-pages.
  final Map<String, Widget> routes = {};

  Future<List<dynamic>>? _moderatorsData;
  String modUsername = "";
  Map<String, dynamic> modData = {};

  @override
  void initState() {
    super.initState();
    modUsername =
        (UserSingleton().user != null) ? UserSingleton().user!.username : "";
    fetchData();
    initializeRoutes();
  }

  void fetchData() async {
    _moderatorsData = getModeratorsRequest(widget.communityName);
  }

  /// Function to navigate to a different page using a custom route transition.
  void navigateToPage(Widget? route) {
    if (route == null) {
      return;
    }
    if ((route == routes["description_page"] ||
            route == routes["community_type_page"]) &&
        modData["manageSettings"] != true) {
      CustomSnackbar(content: "You aren't authorized to view this page")
          .show(context);
      return;
    }
    if ((route == routes["approved_users_page"] ||
            route == routes["banned_users_page"]) ||
        route == routes["moderators_page"] && modData["manageUsers"] != true) {
      CustomSnackbar(content: "You aren't authorized to view this page")
          .show(context);
      return;
    }
    if ((route == routes["post_types_page"]) &&
        modData["managePostsAndComments"] != true) {
      CustomSnackbar(content: "You aren't authorized to view this page")
          .show(context);
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

  void initializeRoutes() {
    routes.addAll({
      "description_page": DescriptionPage(
        communityName: widget.communityName,
      ),
      "community_type_page": CommunityTypePage(
        communityName: widget.communityName,
      ),
      "post_types_page": PostTypes(
        communityName: widget.communityName,
      ),
      "discovery_page": DummyPage(
        communityName: widget.communityName,
      ),
      "content_tags_page": DummyPage(
        communityName: widget.communityName,
      ),
      "scheduled_posts_page": DummyPage(
        communityName: widget.communityName,
      ),
      "moderators_page": ModeratorsPage(
        communityName: widget.communityName,
      ),
      "approved_users_page": ApprovedUsersPage(
        communityName: widget.communityName,
      ),
      "banned_users_page": BannedUsersPage(
        communityName: widget.communityName,
      ),
    });

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
        onPressed: () => navigateToPage(routes["post_types_page"]),
      ),
      ToPageBtn(
        iconData: Icons.explore_outlined,
        mainText: "Discovery",
        onPressed: () => navigateToPage(routes["discovery_page"]),
      ),
      ToPageBtn(
        iconData: Icons.local_offer_outlined,
        mainText: "Content Tags",
        onPressed: () => navigateToPage(routes["content_tags_page"]),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(237, 236, 236, 234),
      appBar: SettingsAppBar(
        title: "Moderator tools",
      ),
      body: FutureBuilder(
        future: _moderatorsData,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoaderWidget(
                dotSize: 10,
                logoSize: 100,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error fetching data 😔"));
          } else if (snapshot.hasData) {
            int index = snapshot.data!
                .indexWhere((item) => item["username"] == modUsername);
            modData = (index != -1) ? snapshot.data![index] : {};
            return SingleChildScrollView(
              child: Column(
                children: [
                  SettingsSectionTitle(title: "General"),
                  SettingsSectionBody(sectionChildren: generalSection),
                  SettingsSectionTitle(title: "Content & Regulations"),
                  SettingsSectionBody(
                      sectionChildren: contentAndRegulationsSection),
                  SettingsSectionTitle(title: "User Management"),
                  SettingsSectionBody(sectionChildren: userManagementSection),
                ],
              ),
            );
          } else {
            return Center(child: Text("Unknown error fetching data 🤔"));
          }
        },
      ),
    );
  }
}
