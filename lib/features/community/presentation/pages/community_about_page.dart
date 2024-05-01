import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_about_desc.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_about_mods.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_about_rules.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_app_bar.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';

/// A page that displays community info.
class CommunityAboutPage extends StatefulWidget {
  /// A page that displays information about a community.
  ///
  /// This page provides details and information about a specific community.
  /// It takes a [communityName] parameter to specify the name of the community.
  const CommunityAboutPage({Key? key, required this.communityName})
      : super(key: key);

  final String communityName;

  @override
  State<CommunityAboutPage> createState() => _CommunityAboutPageState();
}

class _CommunityAboutPageState extends State<CommunityAboutPage> {
  /// Represents the data of a community.
  late Map<String, dynamic> communityData;

  /// Represents the link to the community banner.
  String communityBannerLink = "";

  /// Represents the description of the community.
  String communityDescription = "";

  /// Represents the link to the community image.
  String communityImageLink = "";

  /// Represents the rules of the community.
  List<dynamic> communityRules = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// Fetches data for the community.
  ///
  /// This method fetches the community information using the [getCommunityInfo] function
  /// and updates the state with the fetched data. It retrieves the community banner link,
  /// community image link, community description, and community rules from the fetched data.
  /// If the community banner or image link is not available, empty strings are assigned.
  Future<Map<String, dynamic>> fetchData() async {
    return getCommunityInfo(widget.communityName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: LoaderWidget(
              dotSize: 10,
              logoSize: 100,
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("Error while fetching data 😔"),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Color.fromARGB(237, 236, 236, 234),
            appBar: CommunityAppBar(
              bannerImageLink: snapshot.data!["communityBanner"] ?? "",
              communityName: widget.communityName,
              blurImage: true,
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Color.fromARGB(255, 228, 227, 227),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CommunityAboutDesc(
                      communityName: widget.communityName,
                      communityDesc: snapshot.data!["description"] ?? "",
                    ),
                    CommunityAboutRules(
                      communityName: widget.communityName,
                      communityRules: snapshot.data!["rules"] ?? [],
                    ),
                    SizedBox(height: 15),
                    CommunityAboutMods(
                      communityName: widget.communityName,
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: Text("Unknown error fetching data 🤔"));
        }
      },
    );
  }
}
