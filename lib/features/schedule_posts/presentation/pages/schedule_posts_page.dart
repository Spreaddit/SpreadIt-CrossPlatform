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
    print(communityData);
/*
{name: iamtryinggg, rules: [], removalReasons: [], dateCreated: 2024-05-07T00:45:49.938Z, communityBanner: https://res.cloudinary.com/dkkhtb4za/image/upload/v1713046574/uploads/WhatsApp_Image_2024-04-13_at_5.22.35_PM_f0yaln.jpg, image: https://res.cloudinary.com/dkkhtb4za/image/upload/v1713044122/uploads/voAwqXNBDO4JwIODmO4HXXkUJbnVo_mL_bENHeagDNo_knalps.png, description: , is18plus: true, allowNfsw: true, allowSpoile: true, communityType: Public, creator: {_id: 624a6a677c8d9c9f5fd5eb0d, username: basemelgalfy, avatar: https://res.cloudinary.com/dkkhtb4za/image/upload/v1714947771/uploads/avatar-1714947729634.jpg.jpg, banner: }, members: [{_id: 624a6a677c8d9c9f5fd5eb0d, username: basemelgalfy, avatar: https://res.cloudinary.com/dkkhtb4za/image/upload/v1714947771/uploads/avatar-1714947729634.jpg.jpg, banner: }], moderators: [{_id: 624a6a677c8d9c9f5fd5eb0d, username: basemelgalfy, avatar: https://res.cloudinary.com/dkkhtb4za/image/upload/v1714947771/uploads/avatar-1714947729634.jpg.jpg, banner: }], membersCount
*/
    setState(() {
      community = Community(
        name: communityData["name"],
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
          refreshScheduledPosts: () {
            setState(() {});
          },
          subspreaditName: community.name,
          community: community,
        ));
  }
}
