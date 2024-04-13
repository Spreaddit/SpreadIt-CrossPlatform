import 'package:flutter/material.dart';
import 'subreddit_cards.dart';
import '../../data/community.dart';
import '../../data/get_specific_category.dart';

/// `HorizontalScroll` is a StatefulWidget that represents a horizontally scrolling list of communities.
///
/// This widget is stateful, meaning that it can change over time. The state for this widget is defined in `_HorizontalScrollState`.
class HorizontalScroll extends StatefulWidget {
  @override
  _HorizontalScrollState createState() => _HorizontalScrollState();
}

/// `_HorizontalScrollState` is a class that contains the state for a `HorizontalScroll`.
///
/// It has a `communities` property, which is a list of `Community` objects. This list is initially empty.
///
/// The `initState` method is overridden to call `loadCommunities` when the widget is first created. This method is responsible for loading the communities and adding them to the `communities` list.
class _HorizontalScrollState extends State<HorizontalScroll> {
  List<Community> communities = [];

  @override
  void initState() {
    super.initState();
    loadCommunities();
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
    int cardIndex = 1;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List<Widget>.generate((communities.length / 2).ceil(), (i) {
          Community community1 = communities[i * 2];
          Community? community2;
          if ((i * 2) + 1 < communities.length) {
            community2 = communities[(i * 2) + 1];
          }
          return Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                SubredditCard(
                  index: cardIndex++,
                  title: community1.name,
                  description: community1.description,
                  numberOfMembers: community1.membersCount.toString(),
                  image: community1.image!,
                ),
                if (community2 != null)
                  SubredditCard(
                    index: cardIndex++,
                    title: community2.name,
                    description: community2.description,
                    numberOfMembers: community2.membersCount.toString(),
                    image: community2.image!,
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
