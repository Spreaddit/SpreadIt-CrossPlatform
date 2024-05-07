import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/pages/post_card_page.dart';
import 'package:spreadit_crossplatform/features/search/data/get_in_community_search_result.dart';
import 'package:spreadit_crossplatform/features/search/data/get_in_user_search_result.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/comment_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';

/// Responsible for displaying the comments search results.
/// The class displays 1 filter button for Sort.
/// The class also displays a list of [CommentElement] widgets, which is a Custom widget to display the commnets.
/// The class handles the filtering logic upon filter button press , it also handles the logic of tapping a comment search result, which is navigating to the corresponding comment card.
/// The class also checks if the user comes from the home page or from a community page or user profile, to call the correct api accordingly 

class CommentsPageView extends StatefulWidget {
  final String searchItem;
  final String? initialSortFilter;
  final bool? fromUserProfile;
  final bool? fromCommunityPage;
  final String? communityOrUserName;

  const CommentsPageView({
    Key? key,
    required this.searchItem,
    this.initialSortFilter,
    this.fromUserProfile,
    this.fromCommunityPage,
    this.communityOrUserName,
    }) : super(key: key);

  @override
  State<CommentsPageView> createState() => _CommentsPageViewState();
}

class _CommentsPageViewState extends State<CommentsPageView> {

  Map<String,dynamic> comments = {};
  List<Map<String, dynamic>> mappedComments = [];
  String sort = 'relevance';
  String sortText = 'Sort';
  List sortList = [ 'Most relevant','Top', 'New'];
  bool fromCommunityOrUser = false;
  bool? fromUserProfile;
  bool? fromCommunityPage;
  String communityOrUserName = '';
  
  @override
  void initState() {
    super.initState(); 
    if (widget.fromUserProfile != null) {
      fromUserProfile = widget.fromUserProfile!;
    }
    if (widget.fromCommunityPage != null) {
      fromCommunityPage = widget.fromCommunityPage!;
    }
    if(widget.communityOrUserName != null) {
      communityOrUserName = widget.communityOrUserName!;
    }
    if (widget.initialSortFilter != null) {
      sort = widget.initialSortFilter!.toLowerCase();
      sortText = widget.initialSortFilter!; 
    }
    getCommentssResults();
  }

  void getCommentssResults() async {
    if (fromUserProfile != null && fromUserProfile == true) {
      print('dakhalt men hena');
      comments = await getUserSearchResults(widget.searchItem, 'comments', sort, communityOrUserName);
    }
    else if (fromCommunityPage != null && fromCommunityPage == true) {
      comments = await getCommunitySearchResults(widget.searchItem, 'comments', sort, communityOrUserName);
    }
    else {
      comments = await getSearchResults(widget.searchItem, 'comments', sort);
    }
    mappedComments = extractCommentDetails(comments);
    setState(() {});
  }

  List<Map<String, dynamic>> extractCommentDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedComments = [];
    try {
      for (var comment in results) {
        String? imageLink; 
        String? videoLink;
        if (comment['attachments'].isNotEmpty) {
          Map<String, dynamic> firstAttachment = comment['attachments'][0];
          if (firstAttachment['type'] == 'image' && firstAttachment['link'] != null) {
            imageLink = firstAttachment['link'];
          }
          if  (firstAttachment['type'] == 'video' && firstAttachment['link'] != null) {
            videoLink = firstAttachment['link'];
          }
        }
        mappedComments.add({
          'commentId': comment['commentId'] ?? (throw Exception('null')),
          'commentContent': comment['commentContent'] ?? (throw Exception('null')),
          'commentVotes': comment['commentVotes'] ?? (throw Exception('null')),
          'commentDate': comment['commentDate'] ?? (throw Exception('null')),
          'communityName': comment['communityName'] ?? (throw Exception('null')),
          'communityProfilePic': comment['communityProfilePic'] ?? (throw Exception('null')),
          'username': comment['username'] ?? (throw Exception('null')),
          'userProfilePic': comment['userProfilePic'] ?? (throw Exception('null')),
          'postId': comment['postId'] ?? (throw Exception('null')),
          'postDate': comment['postDate'] ?? (throw Exception('null')),
          'postVotes': comment['postVotes'] ?? (throw Exception('null')),
          'postCommentsCount': comment['postCommentsCount'] ?? (throw Exception('null')),
          'postTitle': comment['postTitle'] ?? (throw Exception('null')),
          'image':  imageLink,
          'video': videoLink,
        });
      }
      return mappedComments;
    }
    catch(e) {
      return [];
    }
  }


  void updateSortFilter(int value) {
    switch (value) {
      case (0):
        sort = 'relevance';
        sortText = sortList[0];
        break;
      case(1):
        sort = 'top';
        sortText = sortList[1];
        break;
      case(2):
        sort = 'new';
        sortText = sortList[2];
        break;    
    } 
    getCommentssResults();
  }

  void navigateToComment(String postId, String commentId) {
    Navigator.push(
          context,
          MaterialPageRoute(
            settings: RouteSettings(
              name:
                  '/post-card-page/$postId/true/$commentId/true',
            ),
            builder: (context) => PostCardPage(
              postId: postId,
              commentId: commentId,
              oneComment: true,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF4500),
          ),
        ),
      );
    }
    if (mappedComments.isEmpty) {
      return Image.asset('./assets/images/Empty_Toast.png');
    }
    else {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: FilterButton(
                openBottomSheet: () => openBottomSheet(sortText,sortList,updateSortFilter,context),
                text: 'Sort',
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.only(top:3),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: mappedComments.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => navigateToComment(mappedComments[index]['postId'], mappedComments[index]['commentId']),
                  child: CommentElement(
                    communityName: mappedComments[index]['communityName'],
                    communityIcon: mappedComments[index]['communityProfilePic'],
                    commentorName: mappedComments[index]['username'],
                    commentorIcon: mappedComments[index]['userProfilePic'],
                    postTitle: mappedComments[index]['postTitle'],
                    comment: mappedComments[index]['commentContent'],
                    commentUpvotes: mappedComments[index]['commentVotes'] < 1000 ?
                          mappedComments[index]['commentVotes'].toString() 
                          : '${(mappedComments[index]['commentVotes']/100).truncateToDouble() /10.0}k',
                    postUpvotes: mappedComments[index]['postVotes'] < 1000 ?
                          mappedComments[index]['postVotes'].toString() 
                          : '${(mappedComments[index]['postVotes']/100).truncateToDouble() /10.0}k',
                    commentsCount: mappedComments[index]['postCommentsCount'] < 1000 ?
                          mappedComments[index]['postCommentsCount'].toString() 
                          : '${(mappedComments[index]['postCommentsCount']/100).truncateToDouble() /10.0}k',
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
