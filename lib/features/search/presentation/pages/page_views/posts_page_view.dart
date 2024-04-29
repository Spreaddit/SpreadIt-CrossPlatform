import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/post_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';

class PostsPageView extends StatefulWidget {

  String? sortFilter;
  String? timeFilter;

   PostsPageView({
    this.sortFilter,
    this.timeFilter,
  });

  @override
  State<PostsPageView> createState() => _PostsPageViewState();
}

class _PostsPageViewState extends State<PostsPageView> {

  
  List posts = 
  [
    {
      'communityIcon': './assets/images/LogoSpreadIt.png',
      'communityName': 'r/AskReddit',
      'time': '3mo',
      'postTitle': 'mayyetin abou el software 3ala senin el software 3ala staff el software ana zhe2t ana 3ayza a3ayyat ana 3ayza amout',
      'upvotes': '36 upvote',
      'comments': '50 comment',
      'image': './assets/images/SB-Standees-Spong-3_800x.png',
      'video': null,
    },
    {
    'communityIcon': './assets/images/LogoSpreadIt.png',
    'communityName': 'r/AskReddit',
    'time': '6mo',
    'postTitle': 'Post Title 2',
    'upvotes': '42 upvote',
    'comments': '63 comment',
    'image': './assets/images/SB-Standees-Spong-3_800x.png',
    'video': null,
  },
  {
    'communityIcon': './assets/images/LogoSpreadIt.png',
    'communityName': 'r/AskReddit',
    'time': '9mo',
    'postTitle': 'mayyetin abou el software 3ala senin el software 3ala staff el software ana zhe2t ana 3ayza a3ayyat ana 3ayza amout',
    'upvotes': '58 upvote',
    'comments': '78 comment',
    'image': null,
    'video': null,
  },
  {
    'communityIcon': './assets/images/LogoSpreadIt.png',
    'communityName': 'r/AskReddit',
    'time': '12mo',
    'postTitle': 'Post Title 4',
    'upvotes': '74 upvote',
    'comments': '92 comment',
    'image': null,
    'video': null,
  },
  {
    'communityIcon': './assets/images/LogoSpreadIt.png',
    'communityName': 'r/AskReddit',
    'time': '15mo',
    'postTitle': 'Post Title 5',
    'upvotes': '80 upvote',
    'comments': '105 comment',
    'image': './assets/images/SB-Standees-Spong-3_800x.png',
    'video': null,
  },
  {
    'communityIcon': './assets/images/LogoSpreadIt.png',
    'communityName': 'r/AskReddit',
    'time': '18mo',
    'postTitle': 'Post Title 6',
    'upvotes': '95 upvote',
    'comments': '120 comment',
    'image': './assets/images/SB-Standees-Spong-3_800x.png',
    'video': null,
  },
  {
    'communityIcon': './assets/images/LogoSpreadIt.png',
    'communityName': 'r/AskReddit',
    'time': '21mo',
    'postTitle': 'Post Title 7',
    'upvotes': '110 upvote',
    'comments': '135 comment',
    'image': './assets/images/SB-Standees-Spong-3_800x.png',
    'video': null,
  },
  {
    'communityIcon': './assets/images/LogoSpreadIt.png',
    'communityName': 'r/AskReddit',
    'time': '24mo',
    'postTitle': 'Post Title 8',
    'upvotes': '126 upvote',
    'comments': '150 comment',
    'image': './assets/images/SB-Standees-Spong-3_800x.png',
    'video': null,
  },
  {
    'communityIcon': './assets/images/LogoSpreadIt.png',
    'communityName': 'r/AskReddit',
    'time': '27mo',
    'postTitle': 'Post Title 9',
    'upvotes': '142 upvote',
    'comments': '165 comment',
    'image': null,
    'video': null,
  },
  {
    'communityIcon': './assets/images/LogoSpreadIt.png',
    'communityName': 'r/AskReddit',
    'time': '30mo',
    'postTitle': 'Post Title 10',
    'upvotes': '158 upvote',
    'comments': '180 comment',
    'image': './assets/images/SB-Standees-Spong-3_800x.png',
    'video': null,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            padding: EdgeInsets.only(top:3),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostElement(
                communityIcon: posts[index]['communityIcon'],
                communityName: posts[index]['communityName'],
                time : posts[index]['time'], 
                postTitle: posts[index]['postTitle'],
                upvotes: posts[index]['upvotes'],
                comments: posts[index]['comments'],
                image: posts[index]['image'],
                video: posts[index]['video'],
                );
            }
          ),
        ],
      ), 
    );
  }
}