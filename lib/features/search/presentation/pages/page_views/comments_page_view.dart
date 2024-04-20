import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/filter_button.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/page_views_elemets/comment_element.dart';
import 'package:spreadit_crossplatform/features/search/presentation/widgets/radio_button_bottom_sheet.dart';

class CommentsPageView extends StatefulWidget {
  const CommentsPageView({Key? key}) : super(key: key);

  @override
  State<CommentsPageView> createState() => _CommentsPageViewState();
}

class _CommentsPageViewState extends State<CommentsPageView> {

  List comments = [
    {
      'communityName': 'r/Cats',
      'communityIcon': './assets/images/GoogleLogo.png',
      'commentorName': 'HeartlessUniverse',
      'commentorIcon': './assets/images/LogoSpreadIt.png',
      'postTitle': 'My cat has a brain tumor',
      'comment': 'Hello friend, I am a veterinary technician who specializes in end-of-life care. I strongly support your decision no to purue surgery or other invasive and painfull therapies. Here is my advice: Provide your little friend with comfort and love.Enjoy the love they give you with renewed understanding of how preccious it is.',
      'commentUpvotes': '3.9k',
      'postUpvotes': '18.1k',
      'commentsCount': '558',
    },
    {
    'communityName': 'r/Dogs',
    'communityIcon': './assets/images/GoogleLogo.png',
    'commentorName': 'DogLover123',
    'commentorIcon': './assets/images/LogoSpreadIt.png',
    'postTitle': 'Looking for advice on training my new puppy',
    'comment': 'Hi there! I have a new puppy and I\'m struggling with potty training. Any tips or advice would be greatly appreciated.',
    'commentUpvotes': '1.2k',
    'postUpvotes': '5.7k',
    'commentsCount': '220',
  },
  {
    'communityName': 'r/Travel',
    'communityIcon': './assets/images/GoogleLogo.png',
    'commentorName': 'WanderlustExplorer',
    'commentorIcon': './assets/images/LogoSpreadIt.png',
    'postTitle': 'Solo backpacking trip through Europe',
    'comment': 'I just returned from a solo backpacking trip through Europe, and it was an incredible experience! Feel free to ask me anything about planning, budgeting, or traveling solo.',
    'commentUpvotes': '2.5k',
    'postUpvotes': '10.3k',
    'commentsCount': '380',
  },
  {
    'communityName': 'r/Food',
    'communityIcon': './assets/images/GoogleLogo.png',
    'commentorName': 'FoodieQueen',
    'commentorIcon': './assets/images/LogoSpreadIt.png',
    'postTitle': 'Homemade pizza night!',
    'comment': 'Who else loves homemade pizza night? Share your favorite pizza toppings and recipes!',
    'commentUpvotes': '4.8k',
    'postUpvotes': '22.6k',
    'commentsCount': '780',
  },
  {
    'communityName': 'r/Technology',
    'communityIcon': './assets/images/GoogleLogo.png',
    'commentorName': 'TechGeek42',
    'commentorIcon': './assets/images/LogoSpreadIt.png',
    'postTitle': 'Latest advancements in AI technology',
    'comment': 'AI technology is evolving rapidly. Let\'s discuss the latest advancements, applications, and implications of artificial intelligence.',
    'commentUpvotes': '3.2k',
    'postUpvotes': '15.9k',
    'commentsCount': '640',
  },
  {
    'communityName': 'r/Gaming',
    'communityIcon': './assets/images/GoogleLogo.png',
    'commentorName': 'GamerPro99',
    'commentorIcon': './assets/images/LogoSpreadIt.png',
    'postTitle': 'Upcoming game releases',
    'comment': 'Excited for any upcoming game releases? Share your most anticipated games and discuss your gaming plans!',
    'commentUpvotes': '2.9k',
    'postUpvotes': '12.7k',
    'commentsCount': '450',
  },
  {
    'communityName': 'r/Photography',
    'communityIcon': './assets/images/GoogleLogo.png',
    'commentorName': 'PhotoEnthusiast',
    'commentorIcon': './assets/images/LogoSpreadIt.png',
    'postTitle': 'Tips for capturing stunning landscapes',
    'comment': 'Landscape photography is one of my passions. Let\'s share tips, techniques, and favorite locations for capturing stunning landscapes!',
    'commentUpvotes': '1.9k',
    'postUpvotes': '8.6k',
    'commentsCount': '320',
  },
  {
    'communityName': 'r/Science',
    'communityIcon': './assets/images/GoogleLogo.png',
    'commentorName': 'ScienceNerd88',
    'commentorIcon': './assets/images/LogoSpreadIt.png',
    'postTitle': 'Recent breakthroughs in medical research',
    'comment': 'Medical research is constantly advancing. Let\'s discuss recent breakthroughs, discoveries, and their potential impact on healthcare.',
    'commentUpvotes': '3.6k',
    'postUpvotes': '17.2k',
    'commentsCount': '590',
  },
  ];

  List sort = [ 'Most relevant', 'Top', 'New'];
  List sortActions = [(){}, (){}, (){}];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: FilterButton(
              openBottomSheet: () => openBottomSheet('Sort', sort, sortActions, context),
              text: 'Sort',
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              return CommentElement(
                communityName: comments[index]['communityName'],
                communityIcon: comments[index]['communityIcon'],
                commentorName: comments[index]['commentorName'],
                commentorIcon: comments[index]['commentorIcon'],
                postTitle: comments[index]['postTitle'],
                comment: comments[index]['comment'],
                commentUpvotes: comments[index]['commentUpvotes'],
                postUpvotes: comments[index]['postUpvotes'],
                commentsCount: comments[index]['commentsCount'],
              );
            }
          ),
        ],
      ), 
    );
  }
}