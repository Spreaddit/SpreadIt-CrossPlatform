import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_app_bar.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_info_sect.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_post_feed.dart';
import 'package:spreadit_crossplatform/features/report_feature/presentation/widgets/report_modal.dart';

class CommunityPage extends StatefulWidget {
  CommunityPage({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late Map<String, dynamic> data;
  String communityBannerLink = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    data = await getCommunityInfo(widget.communityName);
    setState(() {
      communityBannerLink = data["communityBanner"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(237, 236, 236, 234),
      appBar: CommunityAppBar(
        bannerImageLink: communityBannerLink,
        communityName: widget.communityName,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 228, 227, 227),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommunityInfoSection(
                communityName: widget.communityName,
              ),
              CommunityPostFeed(
                communityName: widget.communityName,
              ),
              ElevatedButton(
                onPressed: () {
                  ReportModal(context, widget.communityName, "0", "0", true,
                      false, 'galal');
                },
                child: Text("REPORT MEEEEEE (POST / COMMENT)"),
              ),
              ElevatedButton(
                onPressed: () {
                  ReportModal(context, widget.communityName, "0", "0", false,
                      true, 'galal');
                },
                child: Text("REPORT MEEEEEE (USER)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
