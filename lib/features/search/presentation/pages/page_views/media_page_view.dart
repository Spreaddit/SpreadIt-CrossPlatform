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

  String sort = 'relevance';
  String sortText = 'Sort';
  String timeText = 'Time';
  List sortList = [ 'Most relevant','Hot', 'Top', 'New', 'Comment count'];
  List timeList = ['All time', 'Past hour', 'Today', 'Past week', 'Past month', 'Past year'];
  bool showTimeFilter = true;

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



  void removeFilter() {
    setState(() {
      sortText = 'Sort';
      showTimeFilter;
      timeText = 'Time';
    });
  }

  void updateSortFilter(int value) {
    switch (value) {
      case (0):
        sort = 'relevance';
        sortText = sortList[0];
        break;
      case(1):
        sort = 'hot';
        sortText = sortList[1];
        break;
      case(2):
        sort = 'top';
        sortText = sortList[2];
        break;
      case(3):
        sort = 'new';
        sortText = sortList[3];
        break;
      case(4):
        sort = 'comment';
        sortText = sortList[4];
        break;     
    }
   // will i need set state fl switch cases ?
  }

  void updateTimeFilter(int value) {
    switch (value) {
      case (0):
        timeText = timeList[0];
        break;
      case(1):
        timeText = timeList[1];
        break;
      case(2):
        timeText = timeList[2];
        break;
      case(3):
        timeText = timeList[3];
        break;
      case(4):
        timeText = timeList[4];
        break;     
    }
    // implement time filter 
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              if(sortText != 'Sort')
                IconButton(
                  onPressed: removeFilter,
                  icon: Icon(Icons.cancel),
                ),
              FilterButton(
                openBottomSheet: () {
                  openBottomSheet(
                    sortText,
                    sortList,
                    updateSortFilter,
                    context,
                  );
                },
                text: sortText,
              ),
              if (showTimeFilter)
                FilterButton(
                  openBottomSheet: () { 
                    openBottomSheet(
                      timeText,
                      timeList,
                      updateTimeFilter,
                      context,
                    );  
                  },
                  text: timeText,
                ),
            ],
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Container(
                  width: MediaQuery.of(context).size.width/ 2,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top:3),
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
                    padding: EdgeInsets.only(top:3),
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

/* TO DOS :
1) azabat na2l el photos sa7
2) a7ot videos (ask farida)
3) lamma aghayyar el filter fl bottom sheet yeghayyaro fl page nafsaha 
4) a7ot el community fl search bar
5) mock service  */