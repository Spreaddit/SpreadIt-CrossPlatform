import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/search/data/get_in_community_search_result.dart';
import 'package:spreadit_crossplatform/features/search/data/get_in_user_search_result.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/post_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/time_sort.dart';

/// Responsible for displaying the search results for postss.
/// The class also displays a list of [PostElement] widgets, which is a Custom widget to display the posts.
/// The class handles the logic of tapping a post search result, which is navigating to the corresponding post.
/// The class handles the filtering logic upon filter button press , it also handles the logic of tapping a post search result, which is navigating to the corresponding post card.
/// The class also checks if the user comes from the home page or from a community page or user profile, to call the correct api accordingly 

class PostsPageView extends StatefulWidget {

  final String searchItem;
  final String? initialSortFilter;
  final String? initialTimeFilter;
  final bool? fromUserProfile;
  final bool? fromCommunityPage;
  final String? communityOrUserName;

  const PostsPageView({
    required this.searchItem,
    this.initialSortFilter,
    this.initialTimeFilter,
    this.communityOrUserName,
    this.fromUserProfile,
    this.fromCommunityPage,
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
  bool? fromUserProfile;
  bool? fromCommunityPage;
  String communityOrUserName = '';
  
  @override
  void initState() {
    super.initState(); 
    if(widget.fromUserProfile != null) {
      fromUserProfile = widget.fromUserProfile!;
    }
    if(widget.fromCommunityPage != null) {
      fromCommunityPage = widget.fromCommunityPage!;
    }
    if(widget.communityOrUserName != null) {
      communityOrUserName = widget.communityOrUserName!;
    }
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
    if (fromUserProfile != null && fromUserProfile == true) {
      posts = await GetInUserSearchResults().getUserSearchResults(widget.searchItem, 'posts', sort, communityOrUserName);
    }
    else if (fromCommunityPage != null &&  fromCommunityPage == true) {
      posts = await GetInCommunitySearchResults().getCommunitySearchResults(widget.searchItem, 'posts', sort, communityOrUserName);
    }
    else {
      posts = await GetSearchResults().getSearchResults(widget.searchItem, 'posts', sort);
    }
    mappedPosts = extractPostDetails(posts);
    orgMappedPosts = mappedPosts;
    setState(() {});
  }

  List<Map<String, dynamic>> extractPostDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedPosts = [];
    try {
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
          'postId': post['postId'] ?? (throw Exception('null')),
          'title': post['title'] ?? (throw Exception('null')),
          'isNsfw': post['isnsfw'] ?? (throw Exception('null')),
          'isSpoiler': post['isSpoiler'] ?? (throw Exception('null')),
          'votesCount': post['votesCount'] ?? (throw Exception('null')),
          'commentsCount': post['commentsCount'] ?? (throw Exception('null')),
          'createdAt': post['date'] ?? (throw Exception('null')),
          'username': post['username'] ?? (throw Exception('null')),
          'userProfilePic': post['userProfilePic'] ?? (throw Exception('null')),
          'communityName': post['communityname'] ?? (throw Exception('null')),
          'communityProfilePic': post['communityProfilePic'] ?? (throw Exception('null')),
          'image':  imageLink,
          'video': videoLink,
        });
      }
      return mappedPosts;
    }
    catch(e) {
      return [];
    }
  }

  void removeFilter() {
    setState(() {
      sortText = 'Sort';
      showTimeFilter = true;
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
      case(5):
        timeText = timeList[5];
        break;    
    }
    final filteredPosts = sortByTime(orgMappedPosts, timeText);
    mappedPosts = filteredPosts;
    setState((){});
  }


  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF4500),
          ),
        ),
      );
    }
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
                return InkWell(
                  onTap: () =>  navigateToPostCardPage(context, mappedPosts[index]['postId'], true ),
                  child: PostElement(
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
                    ),
                );
              }
            ),
          ],
        ), 
      );
    }
  }
}