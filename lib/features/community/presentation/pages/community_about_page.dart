import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_about_desc.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_about_rules.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_app_bar.dart';

class CommunityAboutPage extends StatefulWidget {
  const CommunityAboutPage({Key? key, required this.communityName})
      : super(key: key);

  final String communityName;

  @override
  State<CommunityAboutPage> createState() => _CommunityAboutPageState();
}

class _CommunityAboutPageState extends State<CommunityAboutPage> {
  late Map<String, dynamic> communityData;
  String communityBannerLink = "";
  String communityDescription = "";
  String communityImageLink = "";
  List<dynamic> communityRules = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    communityData = await getCommunityInfo(widget.communityName);
    setState(() {
      communityBannerLink = communityData["communityBanner"];
      communityImageLink = communityData["image"];
      communityDescription = communityData["description"];
      communityRules = communityData["rules"];
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
