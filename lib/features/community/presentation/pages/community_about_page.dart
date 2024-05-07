import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_about_desc.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_about_rules.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_app_bar.dart';

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

  ///Represents if the user is currently a member 
  bool isMember=false;

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
  /// It also checks if the user is currently a member
  /// If the community banner or image link is not available, empty strings are assigned.
  Future<void> fetchData() async {
    communityData = await getCommunityInfo(widget.communityName);
    setState(() {
      communityBannerLink = communityData["communityBanner"] ?? "";
      communityImageLink = communityData["image"] ?? "";
      communityDescription = communityData["description"];
      communityRules = communityData["rules"];
      isMember=communityData['isMember'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(237, 236, 236, 234),
      appBar: CommunityAppBar(
        bannerImageLink: communityBannerLink,
        communityName: widget.communityName,
        blurImage: true,
        joined: isMember,
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
                communityDesc: communityDescription,
              ),
              CommunityAboutRules(communityName: widget.communityName),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
