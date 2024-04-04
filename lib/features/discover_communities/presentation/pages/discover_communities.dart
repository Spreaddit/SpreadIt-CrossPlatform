import 'package:flutter/material.dart';
import 'category.dart';
import '../widgets/subreddit_cards.dart';
import '../widgets/horizontal_scroll.dart';

class DiscoverCommunitiesPage extends StatelessWidget {
  final List<String> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Communties',
        ),
      ),
      body: DiscoverCommunitiesBody(),
    );
  }
}

class DiscoverCommunitiesBody extends StatelessWidget {
  final List<String> categories = [
    '🏆 Community top charts',
    'Q&As',
    'Funny',
    'Stories & Confessions',
    'Interesting',
    'Memes',
    'Action Games',
    'Cringe & Facepalm',
    'Role-Playing Games',
    'Career',
    'Gaming News & Discussion',
    'Personal Finance',
    'News',
    'Places in Europe',
    'Celebrities',
    'Anime & Manga',
    'Photography',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          Container(
            alignment: Alignment.centerLeft,
            child: Text('   🔥 Trending globally',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
          ),
          // First section with horizontal scrolling
          HorizontalScroll(),
          SizedBox(height: 16.0),
          Container(
            alignment: Alignment.centerLeft,
            child: Text('   🌍 Top globally',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
          ),
          HorizontalScroll(),
          // Second section with vertical scrolling
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return ListTile(
                  title: Text(
                    categories[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                );
              } else {
                return TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.black87,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black87,
                        ),
                      ),
                      Icon(Icons.arrow_right, color: Colors.black87),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPage(
                          categoryName: categories[index],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
