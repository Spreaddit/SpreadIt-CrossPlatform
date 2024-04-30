import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/final_content_page.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import '../widgets/schedule_posts_body.dart';

class SchedulePostsPage extends StatefulWidget {
  final String communityName;

  const SchedulePostsPage({Key? key, required this.communityName})
      : super(key: key);
  @override
  _SchedulePostsPageState createState() => _SchedulePostsPageState();
}

class _SchedulePostsPageState extends State<SchedulePostsPage> {
  bool isThereScheduledPosts = true;
  late Community community = Community(
    name: '',
    description: '',
    rules: [],
    backgroundImage: '',
    image: '',
    membersCount: 0,
  );
  late Map<String, dynamic> communityData;

  @override
  void initState() {
    super.initState();
    fetchCommunityInfo();
  }

  void fetchCommunityInfo() async {
    communityData = await getCommunityInfo(widget.communityName);

    setState(() {
      community = Community(
        name: widget.communityName,
        description: communityData["description"],
        rules: (communityData["rules"] as List<dynamic>)
            .map((item) => Rule.fromJson(item))
            .toList(),
        backgroundImage: communityData["communityBanner"] ?? "",
        image: communityData["image"] ?? "",
        membersCount: communityData["membersCount"],
      );
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Scheduled Posts',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ScheduledPostsBody(
          subspreaditName: community.name,
          community: community,
        ));
  }
}
