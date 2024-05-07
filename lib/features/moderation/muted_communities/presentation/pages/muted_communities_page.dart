import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/data/get_muted_communities.dart';
import 'package:spreadit_crossplatform/features/moderation/muted_communities/presentation/widgets/muted_community_widget.dart';
/// A page for displaying muted communities.
///
/// This page displays a list of communities that the user has muted. It provides
/// information about muted communities and allows users to search for specific
/// communities using a search field.
///
/// Posts from muted communities do not appear in the user's feeds or recommendations.
///
/// Example usage:
///
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => MutedCommunityPage(),
///   ),
/// );
/// ```
/// 
class MutedCommunityPage extends StatefulWidget {
  @override
  _MutedCommunityPageState createState() => _MutedCommunityPageState();
}

class _MutedCommunityPageState extends State<MutedCommunityPage> {
  List<Community> communities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getmutedCommunities();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Muted communities'),
      ),
      backgroundColor: Colors.white,
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
      child: SingleChildScrollView(
        child: Column(children: [
          Text(
              "Posts From muted communities won't show \n up in your feeds or recommendations."),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
          ListView.builder(
            shrinkWrap:
                true, 
            physics:
                NeverScrollableScrollPhysics(), 
            itemCount: 20,
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
        ]),
      ),
    );
  }
}
