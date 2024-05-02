import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/search/data/get_trending_posts.dart';
import 'trending_card_web.dart'; 

class TrendingWebCarousel extends StatefulWidget {
  final int displayedCards;

  const TrendingWebCarousel({
    Key? key,
    this.displayedCards = 5,
  }) : super(key: key);

  @override
  State<TrendingWebCarousel> createState() => _TrendingWebCarouselState();
}

class _TrendingWebCarouselState extends State<TrendingWebCarousel> {
  int displayedCount = 5;
  double scrollPosition = 0.0; 
  
  Map<String,dynamic> trending = {};
  List<Map<String,dynamic>> mappedTrending = [];

  @override
  void initState() {
    super.initState();
    displayedCount = widget.displayedCards;
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
    final communityName = data['community'];
    String? link;
    final firstAttachment = data['attachments'].first; 
    if (firstAttachment['type'] == 'image') {
      link = firstAttachment['link'];
      print(link);
    }
    if (link == null) {
      link = '';
      print('No image found in attachments');
    }

    print('link : $link');
    processedData.add({
      'title': title,
      'content': content,
      'image': link,
      'communityName': communityName,
      'communityIcon': './assets/images/SB-Standees-Spong-3_800x.png'  // hardcoded for now
    });
    return processedData;
  }


  void navigateToSearchResult (String searchItem) {
    Navigator.of(context).pushNamed('/general-search-results', arguments : {
      'searchItem': searchItem,
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(
        height: 205,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: displayedCount,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => navigateToSearchResult(mappedTrending[index]['title']),
              child: TrendingCardWeb(
                image: mappedTrending[index]['image'],
                title: mappedTrending[index]['title'],
                content: mappedTrending[index]['content'],
                communityIcon: mappedTrending[index]['communityIcon'],
                communityName: mappedTrending[index]['communityName'],
              ),
            );
          },
        ),
      ),
    );
  }
}