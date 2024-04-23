import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/get_specific_category.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/data/get_muted_communities.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/presentation/widgets/muted_community_widget.dart';

class MutedCommintyPage extends StatefulWidget {
  @override
  _MutedCommintyPageState createState() => _MutedCommintyPageState();
}

class _MutedCommintyPageState extends State<MutedCommintyPage> {
  List<Community> communities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getmutedCommunities();
    loadCommunities();
  }

  void getmutedCommunities() async {
    GetMutedCommunities getmutedCommunity = GetMutedCommunities();
    List<Community> loadedCommunities =
        await getmutedCommunity.getMutedCommunities();
    setState(() {
      communities = loadedCommunities;
      isLoading = false;
    });
  }

  void loadCommunities() async {
    GetSpecificCommunity getSpecificCommunity = GetSpecificCommunity();
    List<Community> loadedCommunities =
        await getSpecificCommunity.getCommunities('🔥 Trending globally');
    setState(() {
      communities = loadedCommunities;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Muted communities'),
      ),
      body: isLoading
          ? _buildShimmerLoading()
          : Column(
              children: [
                Text(
                    "Posts From muted communities won't show \n up in your feeds or recommendations."),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: communities.length,
                    itemBuilder: (context, index) {
                      return CommunityTile(
                        community: communities[index],
                        isMuted: true,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: Duration(milliseconds: 1000),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(),
            title: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 10.0,
              color: Colors.white,
            ),
            // Remove subtitle here
          );
        },
      ),
    );
  }
}
