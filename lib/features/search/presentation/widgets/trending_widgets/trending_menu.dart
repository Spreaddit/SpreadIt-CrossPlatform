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
    setState(() {}); 
  }

  List<Map<String, dynamic>> extractTrendingData(Map<String, dynamic> data) {
    final processedData = <Map<String, dynamic>>[];
    final title = data['title'];
    final content = data['content'][0] as String;
    String? link;
    for (var attachment in data['attachments']) {
      if (attachment['type'] == 'image') { 
        link = attachment['link'];
        break;
      }
    }
    processedData.add({
      'title': title,
      'content': content,
      'image': link,
    });
    return processedData;
  }

  

  void navigateToSearchResult (String searchItem) {
    Navigator.of(context).pushNamed('./general-search-results', arguments : {
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
                      onTap: () => navigateToSearchResult(trending[index]['title']) ,
                      child: TrendingCardMobile(
                        title: mappedTrending[index]['title'],
                        content: mappedTrending[index]['content'],
                        image: mappedTrending[index]['image'],
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

/* lamma adous 3aleiha t-redirect me lel topic da */