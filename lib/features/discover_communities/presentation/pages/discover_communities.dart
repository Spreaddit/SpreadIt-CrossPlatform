import 'package:flutter/material.dart';
import 'category.dart';
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
    'Entertainment',
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
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black87,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🔥 Trending globally',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
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
                      categoryName: '🔥 Trending globally',
                    ),
                  ),
                );
              },
            ),
          ),
          // First section with horizontal scrolling
          HorizontalScroll(),
          SizedBox(height: 16.0),
          Container(
            alignment: Alignment.centerLeft,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.black87,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🌍 Top globally',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
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
                      categoryName: '🌍 Top globally',
                    ),
                  ),
                );
              },
            ),
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
