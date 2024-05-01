import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/get_search_results.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/comment_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';

class CommentsPageView extends StatefulWidget {
  final String searchItem;
  const CommentsPageView({Key? key, required this.searchItem}) : super(key: key);

  @override
  State<CommentsPageView> createState() => _CommentsPageViewState();
}

class _CommentsPageViewState extends State<CommentsPageView> {

  Map<String,dynamic> comments = {};
  List<Map<String, dynamic>> mappedComments = [];
  String sort = 'relevance';
  String sortText = 'Sort';
  List sortList = [ 'Most relevant','Top', 'New'];
  
  @override
  void initState() {
    super.initState(); 
    getCommentssResults();
  }

  void getCommentssResults() async {
    comments = await getSearchResults(widget.searchItem, 'posts', sort);
    mappedComments = extractCommentDetails(comments);
    setState(() {});
  }

  List<Map<String, dynamic>> extractCommentDetails(Map<String, dynamic> data) {
    List<dynamic> results = data['results'];
    List<Map<String, dynamic>> mappedComments = [];
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
        'commentId': comment['commentId'],
        'commentContent': comment['commentContent'],
        'commentVotes': comment['commentVotes'],
        'commentDate': comment['commentDate'],
        'communityName': comment['communityName'],
        'communityProfilePic': comment['communityProfilePic'],
        'username': comment['username'],
        'userProfilePic': comment['userProfilePic'],
        'postDate': comment['postDate'],
        'postVotes': comment['postVotes'],
        'postCommentsCount': comment['postCommentsCount'],
        'postTitle': comment['postTitle'],
        'image':  imageLink,
        'video': videoLink,
      });
    }
    return mappedComments;
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

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
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
                return CommentElement(
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
                );
              }
            ),
          ],
        ), 
      );
    }
  }
}
