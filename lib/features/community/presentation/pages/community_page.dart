import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_app_bar.dart';
import 'package:spreadit_crossplatform/features/community/presentation/widgets/community_info_sect.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';

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
  late Map<String, dynamic> data;
  String communityBannerLink = "";
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Fetches the community information.
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
        controller: _scrollController,
        child: Container(
          color: Color.fromARGB(255, 228, 227, 227),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommunityInfoSection(
                communityName: widget.communityName,
              ),
              PostFeed(
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
      ),
    );
  }
}
