import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:spreadit_crossplatform/features/search/presentation/widgets/trending_widgets/trending_card_mobile.dart';

class TrendingMenu extends StatefulWidget {
  const TrendingMenu({Key? key}) : super(key: key);

  @override
  State<TrendingMenu> createState() => _TrendingMenuState();
}

class _TrendingMenuState extends State<TrendingMenu> {


  List trending = [
    {
      'title': 'CyberTruck recall',
      'content':'Tesla recalls the CyberTruck for faulty accelerator pedals that can get stuck',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'onTap': (){},
    },
    {
      'title': 'Pokemon GO avatars',
      'content':'how all the Pokemon GO avatars look like after the new update',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'onTap': (){},
    },
    {
      'title': 'Helldivers 2 major order',
      'content':'hey guys can yo chill out',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'onTap': (){},
    },
    {
      'title': 'taslimet el software etbakkaret',
      'content':'mayyetin abou el software 3ala abou el qesm el m3affen da',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'onTap': (){},
    },
    ];

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
    return Row();
    }
    else {
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
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {trending[index]['onTap'];} ,
                      child: TrendingCardMobile(
                        title: trending[index]['title'],
                        content: trending[index]['content'],
                        image: trending[index]['image'],
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
}

/* lamma adous 3aleiha t-redirect me lel topic da */