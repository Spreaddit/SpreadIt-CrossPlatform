import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  
    List cards = [
    {
      'title': 'CyberTruck recall',
      'content':'Tesla recalls the CyberTruck for faulty accelerator pedals that can get stuck',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'communityIcon': './assets/images/LogoSpreadIt.png',
      'communityName': 'r/AskReddit',
    },
    {
      'title': 'Pokemon GO avatars',
      'content':'how all the Pokemon GO avatars look like after the new update',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'communityIcon': './assets/images/LogoSpreadIt.png',
      'communityName': 'r/AskReddit',
    },
    {
      'title': 'Helldivers 2 major order',
      'content':'hey guys can yo chill out',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'communityIcon': './assets/images/LogoSpreadIt.png',
      'communityName': 'r/AskReddit',
    },
    {
      'title': 'taslimet el software etbakkaret',
      'content':'mayyetin abou el software 3ala abou el qesm el m3affen da',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'communityIcon': './assets/images/LogoSpreadIt.png',
      'communityName': 'r/AskReddit',
    },
    {
      'title': 'taslimet el software etbakkaret',
      'content':'mayyetin abou el software 3ala abou el qesm el m3affen da',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'communityIcon': './assets/images/LogoSpreadIt.png',
      'communityName': 'r/AskReddit',
    },
  ];

  @override
  void initState() {
    super.initState();
    displayedCount = widget.displayedCards;
  }

  void navigateToSearchResult (String searchItem) {
    Navigator.of(context).pushNamed('./general-search-results', arguments : {
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
              onTap: () => navigateToSearchResult(cards[index]['title']),
              child: TrendingCardWeb(
                image: cards[index]['image'],
                title: cards[index]['title'],
                content: cards[index]['content'],
                communityIcon: cards[index]['communityIcon'],
                communityName: cards[index]['communityName'],
              ),
            );
          },
        ),
      ),
    );
  }
}