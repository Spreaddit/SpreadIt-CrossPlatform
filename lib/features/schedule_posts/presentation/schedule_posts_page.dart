import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/final_content_page.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';

class SchedulePostsPage extends StatefulWidget {
  final String communityName;

  const SchedulePostsPage({Key? key, required this.communityName})
      : super(key: key);
  @override
  _SchedulePostsPageState createState() => _SchedulePostsPageState();
}

class _SchedulePostsPageState extends State<SchedulePostsPage> {
  bool isThereScheduledPosts = false;
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
          title: const Text('Scheduled Posts'),
        ),
        body: isThereScheduledPosts
            ? const Center(
                child:
                    CircularProgressIndicator(), // add the scheduled posts here
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.schedule,
                    size: 35,
                    color: const Color.fromARGB(255, 92, 92, 92),
                  ),
                  Text(
                    'There aren\'t any scheduled posts in',
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 92, 92, 92),
                    ),
                  ),
                  Text(
                    'in r/${community.name} yet.',
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 92, 92, 92),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FinalCreatePost(
                              title: '',
                              content: '',
                              community: [community],
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(16),
                        backgroundColor: Color.fromARGB(255, 6, 107, 190),
                      ),
                      child: Text(
                        'Schedule Post',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              )));
  }
}
