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
     List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedTrending = [];
    try {
      for (var trending in results) {
        String? imageLink; 
        String? videoLink;
        if (trending['attachments'].isNotEmpty) {
          Map<String, dynamic> firstAttachment = trending['attachments'][0];
          if (firstAttachment['type'] == 'image' && firstAttachment['link'] != null) {
            imageLink = firstAttachment['link'];
          }
          if  (firstAttachment['type'] == 'video' && firstAttachment['link'] != null) {
            videoLink = firstAttachment['link'];
          }
        }
        mappedTrending.add({
          'postId': trending['postId'] ?? (throw Exception('null')),
          'title': trending['title'] ?? (throw Exception('null')),
          'content': trending['content'] ?? (throw Exception('null')),
          'isNsfw': trending['isNsfw'] ?? (throw Exception('null')),
          'isSpoiler': trending['isSpoiler'] ?? (throw Exception('null')),
          'votesCount': trending['votesCount'] ?? (throw Exception('null')),
          'commentsCount': trending['commentsCount'] ?? (throw Exception('null')),
          'createdAt': trending['date'] ?? (throw Exception('null')),
          'username': trending['username'] ?? (throw Exception('null')),
          'userProfilePic': trending['userProfilePic'] ?? (throw Exception('null')),
          'communityName': trending['communityName'] ?? (throw Exception('null')),
          'communityProfilePic': trending['communityProfilePic'] ?? (throw Exception('null')),
          'image':  imageLink,
          'video': videoLink,
        });
      }
      return mappedTrending;
    }
    catch(e) {
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
                communityIcon: mappedTrending[index]['communityProfilePic'],
                communityName: mappedTrending[index]['communityName'],
              ),
            );
          },
        ),
      ),
    );
  }
}