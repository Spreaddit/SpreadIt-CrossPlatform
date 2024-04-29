import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/media_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';

class MediaPageView extends StatefulWidget {
  
  String? sortFilter;
  String? timeFilter;

  MediaPageView({
    this.sortFilter,
    this.timeFilter,
  });

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

  void removeFilter() {
    setState(() {
      widget.sortFilter = 'Most relevant';
      widget.timeFilter = 'All time';
    });
  }

  void updateSortFilter(value) {
    setState(() => widget.sortFilter = value);
  }

  void updateTimeFilter(value) {
    setState(() => widget.timeFilter = value);
  }


  @override
  Widget build(BuildContext context) {

    bool ShowTimeFilter = widget.sortFilter != 'New' && widget.sortFilter != 'Hot';

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
              children: [
                if(widget.sortFilter !=null)
                  IconButton(
                    onPressed: removeFilter,
                    icon: Icon(Icons.cancel),
                  ),
                FilterButton(
                openBottomSheet: () {
                  openBottomSheet(
                    'Sort',
                     sort,
                    sortActions,
                    widget.sortFilter,
                    context,
                  );
                },
                text: widget.sortFilter != null ? widget.sortFilter! :'Sort',
                ),
                if (ShowTimeFilter)
                  FilterButton(
                  openBottomSheet: () { 
                    openBottomSheet(
                      'Time',
                      time,
                      timeActions,
                      widget.timeFilter,
                      context,
                    );  
                  },
                  text: widget.timeFilter != null ? widget.timeFilter! :'Time',
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