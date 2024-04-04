import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/comments_dummy.dart';
import '../../../homepage/data/get_feed_posts.dart';
import '../../../homepage/presentation/widgets/post_feed.dart';
import '../../data/comments.dart';
import '../../data/community.dart';
import '../widgets/about.dart';
import '../widgets/active_community.dart';
import '../widgets/comments.dart';
import '../../../generic_widgets/custom_bar.dart';
import '../widgets/profile_header.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int _selectedIndex = 0;
  String backgroundImage =
      'https://t1.gstatic.com/licensed-image?q=tbn:ANd9GcRM0OQsITDDUQ-PCjobiXAyUfEQn1sOAkjorPKB2miR-sYx_aCjqMSevH2Y4WjIvPoA';
  String profilePicture =
      'https://yt3.googleusercontent.com/-CFTJHU7fEWb7BYEb6Jh9gm1EpetvVGQqtof0Rbh-VQRIznYYKJxCaqv_9HeBcmJmIsp2vOO9JU=s900-c-k-c0x00ffffff-no-rj';
  String username = "mimo";
  String userinfo = "u/mimo • 43 karma • Jun 6,2020";
  String about = "Don't take ay haga seriously";

  final List<Comment> commentsList = comments;
  final List<Community> communitiesList = communities;

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void navigateToEditProfile(BuildContext context) {
    Navigator.of(context).pushNamed('/edit-profile');
  }

  Widget _buildSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (communitiesList.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  child: Text(
                    'Active Communities',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              if (communitiesList.isNotEmpty)
                SizedBox(
                  height: kIsWeb
                      ? MediaQuery.of(context).size.height * 0.25
                      : MediaQuery.of(context).size.height * 0.21,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: communitiesList.map((community) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: ActiveCommunity(
                            community: community,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              PostFeed(
                postCategory: PostCategories.best,
              ),
            ],
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
        return SliverToBoxAdapter(
          child: AboutWidget(
            postKarmaNo: '100',
            commentKarmaNo: '200',
            aboutText: about,
            onSendMessagePressed: () {},
            onStartChatPressed: () {},
            myProfile: false,
          ),
        );
      default:
        return SliverToBoxAdapter(
          child: Text('Posts'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProfileHeader(
                backgroundImage: backgroundImage,
                profilePicture: profilePicture,
                username: username,
                userinfo: userinfo,
                about: about,
                myProfile: true,
                followed: true,
                onStartChatPressed: () => {},
                editprofile: () => navigateToEditProfile(context),
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
      ),
    );
  }
}
