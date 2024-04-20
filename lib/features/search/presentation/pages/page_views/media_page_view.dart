import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/media_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';

class MediaPageView extends StatefulWidget {
  const MediaPageView({Key? key}) : super(key: key);

  @override
  State<MediaPageView> createState() => _MediaPageViewState();
}

class _MediaPageViewState extends State<MediaPageView> {

  List media = 
  [
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/LogoSpreadIt.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/GoogleLogo.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/SB-Standees-Spong-3_800x.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/GoogleLogo.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/LogoSpreadIt.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/SB-Standees-Spong-3_800x.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/LogoSpreadIt.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/LogoSpreadIt.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/GoogleLogo.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/SB-Standees-Spong-3_800x.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/LogoSpreadIt.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
    {
      'username': 'r/FlutterEnthusiasts',
      'userIcon': './assets/images/LogoSpreadIt.png',
      'postTitle': 'I think I hate Hello Kitty',
      'media': './assets/images/SB-Standees-Spong-3_800x.png',
    },
  ];

  List sort = [ 'Most relevant','Hot', 'Top', 'New', 'Comment count'];
  List sortActions = [(){}, (){}, (){}, (){}, (){},];

  List time = ['All time', 'Past hour', 'Today', 'Past week', 'Past month', 'Past year'];
  List timeActions = [(){}, (){}, (){}, (){}, (){},(){}];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
              children: [
                FilterButton(
                openBottomSheet: () => openBottomSheet('Sort', sort, sortActions, context),
                text: 'Sort',
                ),
                FilterButton(
                openBottomSheet: () => openBottomSheet('Time', time, timeActions, context),
                text: 'Time',
                ),
              ],
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  width: MediaQuery.of(context).size.width/ 2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: media.length ~/ 2,
                    itemBuilder: (context, index) {
                      return MediaElement(
                        username: media[index]['username'],
                        userIcon: media[index]['userIcon'],
                        postTitle: media[index]['postTitle'],
                        media: media[index]['media'],
                      );
                    }
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width /2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: media.length ~/ 2,
                    itemBuilder: (context, index) {
                      return MediaElement(
                        username: media[index + media.length ~/2]['username'],
                        userIcon: media[index + media.length ~/2]['userIcon'],
                        postTitle: media[index + media.length ~/2]['postTitle'],
                        media: media[index + media.length ~/2]['media'],
                      );
                    }
                  ),
                ),
            ],
          ),
        ],
      ), 
    );
  }
}