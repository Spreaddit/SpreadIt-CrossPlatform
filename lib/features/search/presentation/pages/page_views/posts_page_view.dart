import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/post_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';

class PostsPageView extends StatefulWidget {

  final String searchItem;

  const PostsPageView({
    required this.searchItem,
  });

  @override
  State<PostsPageView> createState() => _PostsPageViewState();
}

class _PostsPageViewState extends State<PostsPageView> {

  
  Map<String,dynamic> posts = {};
  List<Map<String, dynamic>> mappedPosts = [];
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
    posts = await getSearchResults(widget.searchItem, 'posts', sort);
    mappedPosts = extractPostDetails(posts);
    setState(() {});
  }

  List<Map<String, dynamic>> extractPostDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedPosts = [];
    for (var post in results) {
      mappedPosts.add({
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
    return mappedPosts;
  }

  List<Map<String, dynamic>> sortByTime(List<Map<String, dynamic>> posts,String timePeriod) {
    posts.sort((a, b) => b['createdAt'].compareTo(a['createdAt']));
    final filteredPosts = posts.where((post) {
      final createdAt = DateTime.parse(post['createdAt']);
      switch (timePeriod) {
        case 'Past hour':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(hours: 1)));
        case 'Today':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(days: 1)));
        case 'Past week':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(days: 7)));
        case 'Past month':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30)));
        case 'Past year':
          return createdAt.isAfter(DateTime.now().subtract(const Duration(days: 365)));
        default:
          return true; 
      }
    }).toList();

    return filteredPosts;
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
    final filteredPosts = sortByTime(mappedPosts, timeText);
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
                  communityIcon: mappedPosts[index]['userProfilePic'],
                  communityName: mappedPosts[index]['username'],
                  time : dateToDuration(DateTime.parse(mappedPosts[index]['createdAt'])), 
                  postTitle: mappedPosts[index]['title'],
                  upvotes: mappedPosts[index]['votesCount'].toString(),
                  comments: mappedPosts[index]['commentCount'].toString(),
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