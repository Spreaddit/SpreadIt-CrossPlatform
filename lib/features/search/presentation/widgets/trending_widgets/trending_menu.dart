import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:spreadit_crossplatform/features/search/data/get_trending_posts.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/trending_widgets/trending_card_mobile.dart';

class TrendingMenu extends StatefulWidget {
  const TrendingMenu({Key? key}) : super(key: key);

  @override
  State<TrendingMenu> createState() => _TrendingMenuState();
}

class _TrendingMenuState extends State<TrendingMenu> {


  Map<String,dynamic> trending = {};
  List<Map<String,dynamic>> mappedTrending = [];

  @override
  void initState() {
    super.initState();
    getTrending();
  }

  void getTrending() async {
    trending = await getTrendingPosts();
    mappedTrending = extractTrendingData(trending);
    setState((){});
  }

  List<Map<String, dynamic>> extractTrendingData(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedTrending = [];
    try {
      for (var trending in results) {
        String? imageLink; 
        String? videoLink;
        String? content;
        if (trending['attachments'].isNotEmpty) {
          Map<String, dynamic> firstAttachment = trending['attachments'][0];
          if (firstAttachment['type'] == 'image' && firstAttachment['link'] != null) {
            imageLink = firstAttachment['link'];
          }
          if  (firstAttachment['type'] == 'video' && firstAttachment['link'] != null) {
            videoLink = firstAttachment['link'];
          }
        }
        if (trending['content'] == []) {
           content = '';
        }
        mappedTrending.add({
          'postId': trending['postId'] ?? (throw Exception('postId')),
          'title': trending['title'] ?? (throw Exception('title')),
          'content': content,
          'image':  imageLink,
          'video': videoLink,
        });
      }
      return mappedTrending;
    }
    catch(e) {
      print('mapping error $e');
      return [];
    }
  }

  void navigateToSearchResult (String searchItem) {
    Navigator.of(context).pushNamed('/general-search-results', arguments : {
      'searchItem': searchItem,
    }); 
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Trending Today',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top:3),
                  itemCount: mappedTrending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => navigateToSearchResult(mappedTrending[index]['title']) ,
                      child: TrendingCardMobile(
                        title: mappedTrending[index]['title'],
                        content: mappedTrending[index]['content'],
                        image: mappedTrending[index]['image'],
                        video: mappedTrending[index]['video'],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      );
    }
  }

