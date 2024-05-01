import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spreadit_crossplatform/features/community/presentation/pages/community_about_page.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_join.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_moderators_data.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/modtools_page_btn.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// A widget that displays information about a community.
class CommunityInfoSection extends StatefulWidget {
  const CommunityInfoSection(
      {Key? key, required this.communityName, required this.communityData})
      : super(key: key);

  /// The name of the community.
  final String communityName;

  /// The information about the community.
  final Map<String, dynamic> communityData;

  @override
  State<CommunityInfoSection> createState() => _CommunityInfoSectionState();
}

class _CommunityInfoSectionState extends State<CommunityInfoSection> {
  String membersCount = "0";
  String communityDescription = "";
  String communityImageLink = "";

  Future<Map<String, dynamic>>? modData;

  @override
  void initState() {
    super.initState();
    initValues();
    fetchModData();
  }

  /// Initializes the values of the community information.
  void initValues() {
    membersCount = formatNumber(widget.communityData["membersCount"] ?? 0);
    communityImageLink = widget.communityData["image"] ?? "";
    communityDescription = widget.communityData["description"] ?? "";
    // TODO: Check if user is a moderator
  }

  /// Formats a number using the NumberFormat class.
  formatNumber(dynamic myNumber) {
    myNumber.toString();
    NumberFormat numberFormat =
        NumberFormat.compact(locale: "en_US", explicitSign: false);
    return numberFormat.format(myNumber);
  }

  /// Fetches the moderator data.
  void fetchModData() async {
    modData = checkIfModeratorRequest(
      communityName: widget.communityName,
      username:
          (UserSingleton().user != null) ? UserSingleton().user!.username : "ss",
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: modData,
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrangeAccent,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error while fetching data 😔"),
          );
        } else if (snapshot.hasData && snapshot.data != {}) {
          print(modData);
          return Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          CircleAvatar(
                            foregroundImage: (communityImageLink != "")
                                ? NetworkImage(communityImageLink)
                                : AssetImage('assets/images/LogoSpreadIt.png')
                                    as ImageProvider,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "r/${widget.communityName}",
                                softWrap: true,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 17),
                              ),
                              Text(
                                "$membersCount members",
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 25, 25, 25),
                                  fontSize: 17,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      if (snapshot.data!["isModerator"] ?? false)
                        ModtoolsPageBtn(
                          communityName: widget.communityName,
                        ),
                      if (!(snapshot.data!["isModerator"] ?? false))
                        JoinCommunityBtn(
                          communityName: widget.communityName,
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      communityDescription,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 96, 95, 95)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Colors.grey.withOpacity(0.5)),
                    ),
                    child: Text(
                      'See more',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 4, 66, 117),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommunityAboutPage(
                            communityName: widget.communityName,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text("Unknown error fetching data 🤔"));
        }
      },
    );
  }
}
