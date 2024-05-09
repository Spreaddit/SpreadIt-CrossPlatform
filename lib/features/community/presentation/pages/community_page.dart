import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/accept_invite.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/community/data/decline_invite.dart';
import 'package:spreadit_crossplatform/features/community/data/get_permissions.dart';
import 'package:spreadit_crossplatform/features/community/data/mod_permissions.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_app_bar.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_info_sect.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/fail_to_fetch.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/non_skippable_dialog.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/moderators-page.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_approved_users.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_banned_users.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_invited.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_moderators_data.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// A page that displays the community page, info, and posts.
class CommunityPage extends StatefulWidget {
  /// The name of the community.
  final String communityName;

  /// Creates a [CommunityPage] with the given [communityName].
  CommunityPage({Key? key, required this.communityName}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  bool isInitialized = false;
  late Map<String, dynamic> data;
  String communityBannerLink = "";
  ScrollController _scrollController = ScrollController();
  late Future<Map<String, dynamic>> communityDataFuture;
  late Future<Map<String, dynamic>> isApprovedDataFuture;
  late Future<Map<String, dynamic>> isBannedDataFuture;
  late Future<Map<String, dynamic>> isModDataFuture;
  late Future<Map<String, dynamic>> isInvitedFuture;
  late Future<ModPermissions> permissionsFuture;
  int communityDataIdx = 0;
  int isApprovedDataIdx = 1;
  int isBannedDataIdx = 2;
  Map<String, dynamic> isModData = {};
  Map<String, dynamic> isInvitedData = {};
  Map<String, dynamic> communityData = {};
  Map<String, dynamic> isApprovedData = {};
  Map<String, dynamic> isBannedData = {};
  ModPermissions? permissionsData;
  List<List<String>> alertTexts = [
    [
      "You are banned from this community 🔨",
      "You are banned from this community and cannot view its content 🛑."
    ],
    ["You are not an approved user 🔐", "This is a private community 🫣"]
  ];
  bool isMember = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// Fetches the community information.
  Future<void> fetchData() async {
    communityDataFuture = getCommunityInfo(widget.communityName).then((value) {
      communityData = value;
      setState(() {
        communityBannerLink = communityData["communityBanner"];
        isMember = communityData['isMember'];
        data = communityData;
      });
      return communityData;
    });
    isApprovedDataFuture = checkIfApprovedRequest(
      communityName: widget.communityName,
      username:
          (UserSingleton().user != null) ? UserSingleton().user!.username : "",
    ).then((value) => isApprovedData = value);
    isBannedDataFuture = checkIfBannedRequest(
      communityName: widget.communityName,
      username:
          (UserSingleton().user != null) ? UserSingleton().user!.username : "",
    ).then((value) => isBannedData = value);
    isModDataFuture = checkIfModeratorRequest(
      communityName: widget.communityName,
      username:
          (UserSingleton().user != null) ? UserSingleton().user!.username : "",
    ).then((value) => isModData = value);
    isInvitedFuture = checkIfInvitedRequest(
      communityName: widget.communityName,
      username:
          (UserSingleton().user != null) ? UserSingleton().user!.username : "",
    ).then((value) => isInvitedData = value);
    permissionsFuture = fetchPermissionsData(
      widget.communityName,
      (UserSingleton().user != null) ? UserSingleton().user!.username : "",
    ).then((value) => permissionsData = value!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        communityDataFuture,
        isApprovedDataFuture,
        isBannedDataFuture,
        isModDataFuture,
        isInvitedFuture,
        permissionsFuture,
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoaderWidget(
              dotSize: 10,
              logoSize: 100,
            ),
          );
        }
        if (snapshot.hasError) {
          return FailToFetchPage(
            displayWidget: Text("Error while fetching data 😔"),
          );
        } else if (snapshot.hasData) {
          print("Fetching is complete");
          print("communityData: $communityData");
          print("isApprovedData: $isApprovedData");
          print("isBannedData: $isBannedData");
          if (!isInitialized) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              String title = "";
              String content = "";
              if (isBannedData["isBanned"] == true) {
                title = alertTexts[0][0];
                content = alertTexts[0][1];
                _showHaltingAlert(title: title, content: content);
              } else if (communityData["communityType"] == "Private" &&
                  isApprovedData["isContributor"] == false &&
                  communityData["isModerator"] == false) {
                title = alertTexts[1][0];
                content = alertTexts[1][1];
                _showHaltingAlert(title: title, content: content);
              } else if (isInvitedData["isInvited"] == true) {
                _showInvitationDialog();
              }
            });

            isInitialized = true;
          }
          return Scaffold(
            backgroundColor: Color.fromARGB(237, 236, 236, 234),
            appBar: CommunityAppBar(
              bannerImageLink: communityData["communityBanner"],
              communityName: widget.communityName,
              joined: communityData["isMember"],
              onStateChange: () {
                fetchData().then((value) => setState(() {}));
              },
            ),
            body: _buildNormalBody(),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.create),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('/final-content-page', arguments: {
                  'title': "",
                  'content': "",
                  'community': [Community.fromJson(communityData)],
                  'isFromCommunityPage': true,
                }).then((value) => setState(() {}));
              },
            ),
          );
        } else {
          return FailToFetchPage(
              displayWidget: Text("Unknown error fetching data 🤔"));
        }
      },
    );
  }

  Widget _buildNormalBody() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        color: Color.fromARGB(255, 228, 227, 227),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommunityInfoSection(
              communityName: widget.communityName,
              communityData: communityData,
              onReturnToCommunityPage: () {
                fetchData().then((value) => setState(() {}));
              },
            ),
            PostFeed(
              isModeratorView: isModData['isModerator'],
              canManagePosts: permissionsData!.managePostsAndComments,
              postCategory: PostCategories.hot,
              subspreaditName: widget.communityName,
              startSortIndex: 1,
              endSortIndex: 3,
              showSortTypeChange: true,
              scrollController: _scrollController,
            ),
          ],
        ),
      ),
    );
  }

  void _showHaltingAlert({required String title, required String content}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NonSkippableAlertDialog(
          title: title,
          content: content,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showInvitationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Invitation to moderate"),
          content: Text("You've been invited to moderate this community."),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Accept invitation logic
                    acceptInvite(communityName: widget.communityName);
                    //Navigate to moderators page
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ModeratorsPage(
                          communityName: widget.communityName,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all(
                        Size(150, 50)), // Set minimum size of the button
                  ),
                  child: Text(
                    "Accept",
                    style: TextStyle(fontSize: 20), // Adjust text size
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Decline invitation logic
                    declineInvite(
                      communityName: widget.communityName,
                    );

                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        Size(150, 50)), // Set minimum size of the button
                  ),
                  child: Text(
                    "Decline",
                    style: TextStyle(fontSize: 20), // Adjust text size
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
