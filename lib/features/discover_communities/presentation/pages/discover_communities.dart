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

/// `DiscoverCommunitiesBody` is a StatelessWidget that represents the body of the Discover Communities page.
///
/// It contains a list of categories, which are represented as strings. Each string in the list is a category name.
///
/// The list of categories is final and includes categories like  'Q&As', 'Funny', 'Entertainment', and more.
///
/// This widget is stateless, meaning that it describes part of the user interface which can depend on configuration information in the constructor and changeable information in the build method, but does not depend on any mutable state.
class DiscoverCommunitiesBody extends StatelessWidget {
  final List<String> categories = [
    '🏆 Community top charts',
    'Technology',
    'Science',
    'Art and Creativity',
    'Mental Health and Psychology',
    'Travel and Adventure',
    'Food and Cooking',
    'Entertainment and Pop Culture',
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
