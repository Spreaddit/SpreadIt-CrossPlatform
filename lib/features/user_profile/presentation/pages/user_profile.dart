import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/comments_dummy.dart';
import '../../../homepage/data/get_feed_posts.dart';
import '../../../homepage/presentation/widgets/post_feed.dart';
import '../../data/comments.dart';
//import '../widgets/about.dart';
import '../widgets/comments.dart';
import '../widgets/custom_bar.dart';
import '../widgets/profile_header.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int _selectedIndex = 0;
  ////////////////////////////////////////////    TO BE TAKEN FROM THE BACKEND ////////////////////////////////////////////////
  String backgroundImage =
      'https://www.shutterstock.com/blog/wp-content/uploads/sites/5/2020/02/Usign-Gradients-Featured-Image.jpg';
  String profilePicture =
      'https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj';
  String username = "mimo";
  String userinfo = "u/mimo • 43 karma • Jun 6,2020"; 
  String about = "Don't take ay haga seriously";

  //////////////////////////////////////           Comments dummy data     ////////////////////////////////////////////////////////
  final List<Comment> commentsList = comments;

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

Widget _buildSelectedPage() {
  switch (_selectedIndex) {
    case 0:
      // Render posts
      return SliverToBoxAdapter(
        child:  PostFeed(
              postCategory: PostCategories.best,
            ),
      );
    case 1:
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final comment = commentsList[index];
            return CommentWidget(comment: comment);
          },
          childCount: commentsList.length,
        ),
      );
    case 2:
      // Render about
      return SliverToBoxAdapter(
        //child: AboutWidget(),
      );
    default:
      // Render posts
      return SliverToBoxAdapter(
        child: Text('Posts'),
      );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProfileHeader(
              backgroundImage: backgroundImage,
              profilePicture: profilePicture,
              username: username,
              userinfo: userinfo,
              about: about,
            ),
          ),
          SliverToBoxAdapter(
            child: CustomBar(
              tabs: ['Posts', 'Comments', 'About'],
              onIndexChanged: _onIndexChanged,
            ),
          ),
          _buildSelectedPage(),
        ],
      ),
    );
  }
}
