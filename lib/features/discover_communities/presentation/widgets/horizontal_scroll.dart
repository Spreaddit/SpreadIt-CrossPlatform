import 'package:flutter/material.dart';
import 'subreddit_cards.dart';

class HorizontalScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SubredditCard(
                  index: 1,
                  title: 'Title',
                  description: 'Description',
                  numberOfMembers: '1000',
                  image: 'https://picsum.photos/205',
                ),
                SubredditCard(
                  index: 2,
                  title: 'Title',
                  description: 'Description',
                  numberOfMembers: '1000',
                  image: 'https://picsum.photos/204',
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SubredditCard(
                  index: 1,
                  title: 'Title',
                  description: 'Description',
                  numberOfMembers: '1000',
                  image: 'https://picsum.photos/202',
                ),
                SubredditCard(
                  index: 2,
                  title: 'Title',
                  description: 'Description',
                  numberOfMembers: '1000',
                  image: 'https://picsum.photos/203',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
