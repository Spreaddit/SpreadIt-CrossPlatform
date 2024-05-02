import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/post_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/time_sort.dart';

class PostsPageView extends StatefulWidget {

  final String searchItem;
  final String? initialSortFilter;
  final String? initialTimeFilter;

  const PostsPageView({
    required this.searchItem,
    this.initialSortFilter,
    this.initialTimeFilter,
  });

  @override
  State<PostsPageView> createState() => _PostsPageViewState();
}

class _PostsPageViewState extends State<PostsPageView> {

  
  Map<String,dynamic> posts = {};
  List<Map<String, dynamic>> mappedPosts = [];
  List<Map<String,dynamic>> orgMappedPosts = [];
  String sort = 'relevance';
  String sortText = 'Sort';
  String timeText = 'Time';
  List sortList = [ 'Most relevant','Hot', 'Top', 'New', 'Comment count'];
  List timeList = ['All time', 'Past hour', 'Today', 'Past week', 'Past month', 'Past year'];
  bool showTimeFilter = true;
  
  @override
  void initState() {
    super.initState(); 
    if (widget.initialSortFilter != null) {
      sort = widget.initialSortFilter!.toLowerCase();
      sortText = widget.initialSortFilter!; 
      if(widget.initialSortFilter == 'New') {
        showTimeFilter = false;
      }
    }
    if(widget.initialTimeFilter != null) {
      timeText = widget.initialTimeFilter!;
    }
    getPostsResults();
  }

  void getPostsResults() async {
    posts = await getSearchResults(widget.searchItem, 'posts', sort);
    mappedPosts = extractPostDetails(posts);
    orgMappedPosts = mappedPosts;
    setState(() {});
  }

  List<Map<String, dynamic>> extractPostDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedPosts = [];
    for (var post in results) {
      String? imageLink; 
      String? videoLink;
      if (post['attachments'].isNotEmpty) {
        Map<String, dynamic> firstAttachment = post['attachments'][0];
        if (firstAttachment['type'] == 'image' && firstAttachment['link'] != null) {
          imageLink = firstAttachment['link'];
        }
        if  (firstAttachment['type'] == 'video' && firstAttachment['link'] != null) {
          videoLink = firstAttachment['link'];
        }
      }
      mappedPosts.add({
        'postId': post['postId'],
        'title': post['title'],
        'isNsfw': post['isNsfw'],
        'isSpoiler': post['isSpoiler'],
        'votesCount': post['votesCount'],
        'commentsCount': post['commentsCount'],
        'createdAt': post['date'],
        'username': post['username'],
        'userProfilePic': post['userProfilePic'],
        'communityName': post['communityName'],
        'communityProfilePic': post['communityProfilePic'],
        'image':  imageLink,
        'video': videoLink,
      });
    }
    return mappedPosts;
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
    final filteredPosts = sortByTime(orgMappedPosts, timeText);
    mappedPosts = filteredPosts;
    setState((){});
  }


  @override
  Widget build(BuildContext context) {
    if (mappedPosts.isEmpty) {
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
            ListView.builder(
              padding: EdgeInsets.only(top:3),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mappedPosts.length,
              itemBuilder: (context, index) {
                return PostElement(
                  communityIcon: mappedPosts[index]['communityProfilePic'],
                  communityName: mappedPosts[index]['communityName'],
                  time : dateToDuration(DateTime.parse(mappedPosts[index]['createdAt'])), 
                  postTitle: mappedPosts[index]['title'],
                  upvotes: mappedPosts[index]['votesCount'] < 1000 ?
                        mappedPosts[index]['votesCount'].toString() 
                        : '${(mappedPosts[index]['votesCount']/100).truncateToDouble() /10.0}k',
                  comments: mappedPosts[index]['commentsCount'] < 1000 ?
                        mappedPosts[index]['commentsCount'].toString() 
                        : '${(mappedPosts[index]['commentsCount']/100).truncateToDouble() /10.0}k',
                  isNsfw: mappedPosts[index]['isNsfw'],
                  isSpoiler: mappedPosts[index]['isSpoiler'],
                  image: mappedPosts[index]['image'] ,
                  video: mappedPosts[index]['video'],
                  );
              }
            ),
          ],
        ), 
      );
    }
  }
}