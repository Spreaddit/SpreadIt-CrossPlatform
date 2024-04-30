import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/media_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';

class MediaPageView extends StatefulWidget {
  final String searchItem;
  const MediaPageView({Key? key,required this.searchItem}) : super(key: key);

  @override
  State<MediaPageView> createState() => _MediaPageViewState();
}

class _MediaPageViewState extends State<MediaPageView> {

  Map<String,dynamic> media = {};
  List<Map<String, dynamic>> mappedMedia = [];
  String sort = 'relevance';
  String sortText = 'Sort';
  String timeText = 'Time';
  List sortList = [ 'Most relevant','Hot', 'Top', 'New', 'Comment count'];
  List timeList = ['All time', 'Past hour', 'Today', 'Past week', 'Past month', 'Past year'];
  bool showTimeFilter = true;
  
  @override
  void initState() {
    super.initState(); 
    getPostsResults();
  }

  void getPostsResults() async {
    media = await getSearchResults(widget.searchItem, 'posts', sort);
    mappedMedia = extractMediaDetails(media);
    setState(() {});
  }

  List<Map<String, dynamic>> extractMediaDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedMedia = [];
    for (var post in results) {
      if ((post['image'] != null && post['image'].isNotEmpty) || (post['video'] != null && post['video'].isNotEmpty))
      {
        mappedMedia.add({
        'postId': post['postId'],
        'username': post['username'],
        'userProfilePic': post['userProfilePic'],
        'votesCount': post['votesCount'],
        'commentCount': post['commentCount'],
        'title': post['title'],
        'createdAt': post['createdAt'],
        'image': post['image'],
        'video': null,
        });
      }
    }
    return mappedMedia;
  }

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
        showTimeFilter = true;
        break;
      case(1):
        sort = 'hot';
        sortText = sortList[1];
        showTimeFilter = false;
        break;
      case(2):
        sort = 'top';
        sortText = sortList[2];
        showTimeFilter = true;
        break;
      case(3):
        sort = 'new';
        sortText = sortList[3];
        showTimeFilter = false;
        break;
      case(4):
        sort = 'comment';
        sortText = sortList[4];
        showTimeFilter = true;
        break;     
    }
    getPostsResults(); 
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
    if (media.isEmpty) {
      return Image.asset('./assets/images/Empty_Toast.png');
    }
    else {
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
                      itemCount: mappedMedia.length ~/ 2,
                      itemBuilder: (context, index) {
                        return MediaElement(
                          username: mappedMedia[index]['username'],
                          userIcon: mappedMedia[index]['userProfilePic'],
                          postTitle: mappedMedia[index]['title'],
                          media: mappedMedia[index]['image'] != null ? mappedMedia[index]['image'] : mappedMedia[index]['video'],
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
                      itemCount: mappedMedia.length ~/ 2,
                      itemBuilder: (context, index) {
                        return MediaElement(
                          username: mappedMedia[index + mappedMedia.length ~/2]['username'],
                          userIcon: mappedMedia[index + mappedMedia.length ~/2]['userProfilePic'],
                          postTitle: mappedMedia[index + mappedMedia.length ~/2]['title'],
                          media: mappedMedia[index + mappedMedia.length ~/2]['image'] != null ?
                             mappedMedia[index + mappedMedia.length ~/2]['image']
                             :mappedMedia[index + mappedMedia.length ~/2]['video'],
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
}

/* TO DOS :
1) azabat na2l el photos sa7
2) a7ot videos (ask farida)
3) lamma aghayyar el filter fl bottom sheet yeghayyaro fl page nafsaha 
4) a7ot el community fl search bar
5) mock service  */