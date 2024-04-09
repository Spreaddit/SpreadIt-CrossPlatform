import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../../generic_widgets/snackbar.dart';
import '../../../homepage/data/get_feed_posts.dart';
import '../../../homepage/presentation/widgets/post_feed.dart';
import '../../data/class_models/comments_class_model.dart';
import '../../data/class_models/community_class_model.dart';
import '../../data/date_conversion.dart';
import '../../data/follow_unfollow_api.dart';
import '../widgets/about.dart';
import '../widgets/active_community.dart';
import '../widgets/comments.dart';
import '../../../generic_widgets/custom_bar.dart';
import '../widgets/profile_header.dart';
import '../../data/user_info.dart';
import '../../data/class_models/user_info_class_model.dart';
import '../../data/get_user_comments.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int _selectedIndex = 0;
  /////////////////////////////////Navigation ////////////////////////////////////////////////
  bool myProfile = true; ////////// will be taken during navigation
  String username = 'mimo'; ////////// will be taken during navigation

  ////////////////////////////////////////////BACKEND///////////////////////////////////////////
  String backgroundImage = '';
  String profilePicture = '';
  String formattedDate = '';
  UserInfo? userInfoFuture;
  String userinfo = '';
  String about = '';
  String background = '';
  bool? followStatus; 
  String displayName=''; 
  String postKarmaNo = '';
  String commentKarmaNo = '';
  List<Comment> commentsList = [];
  List<Community> communitiesList = [];
  List<Map<String, dynamic>> socialMediaLinks=[];
  File? backgroundImageFile;
  File? profileImageFile;

  @override
  void initState() {
    super.initState();
    fetchUserInfoAsync();
    fetchComments();
  }

 void fetchUserInfoAsync() async {
  try {
    userInfoFuture = await fetchUserInfo(username);
    setState(() {
      formattedDate = formatDate(userInfoFuture!.dateOfJoining);
      userinfo =
          'u/${userInfoFuture!.username} • ${userInfoFuture!.numberOfKarmas} Karma • $formattedDate';
      communitiesList = userInfoFuture!.activeCommunities;
      about = userInfoFuture!.about;
      background = userInfoFuture!.background;
      followStatus = userInfoFuture!.followStatus;
      postKarmaNo = userInfoFuture!.postKarmaNo;
      commentKarmaNo = userInfoFuture!.commentKarmaNo;
      profilePicture = userInfoFuture!.avatar;
      displayName = userInfoFuture!.displayname; 
      socialMediaLinks = userInfoFuture!.socialMedia.map((socialMedia) => {
        'platformName': socialMedia.platform,
        'headerName': socialMedia.displayname,
        'url': socialMedia.url,
      }).toList(); 
    });
  } catch (e) {
    print('Error fetching user info: $e');
  }
}

Future<void> unfollowOrFollow() async {
  try {
     var response= await toggleFollow(isFollowing: followStatus!, username: username);
    if (response==200)
    {
      setState(() {
        followStatus = !followStatus!;
      });
    }
    else if (response==400)
    {
          CustomSnackbar(content: 'Username is required').show(context);

    }
        else if (response==404)
    {
          CustomSnackbar(content: 'User not found').show(context);

    }
        else if (response==500)
    {
          CustomSnackbar(content: 'Internal server error').show(context);

    }
  } catch (e) {
    print('Error toggling follow status: $e');
  }
}


  Future<void> fetchComments() async {
    try {
      var data = await fetchUserComments(username,'user');
      setState(() {
        commentsList = data;
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }


  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

void navigateToEditProfile(BuildContext context) async {

final returnedData = await Navigator.of(context).pushNamed(
    '/edit-profile',
    arguments: {
      'backgroundImageUrl': background,
      'backgroundImageFile': backgroundImageFile,
      'profileImageUrl': profilePicture,
      'profileImageFile': profileImageFile,
      'about': about,
      'displayname': displayName,
      'socialMediaLinks': socialMediaLinks,
    },
  );
  if (returnedData != null && returnedData is Map<String, dynamic>) {
    setState(() {
      backgroundImage = returnedData['backgroundImage']??'' ;
      profilePicture = returnedData['profilePicImage']??'';
      backgroundImageFile= returnedData['backgroundImageFile'];
      profileImageFile= returnedData['profileImageFile'];
      socialMediaLinks = returnedData['socialMedia'] ?? socialMediaLinks;
      about = returnedData['about'] ?? about;
      displayName = returnedData['displayname'] ?? displayName;
    });
  }
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
            postKarmaNo: postKarmaNo,
            commentKarmaNo: commentKarmaNo,
            aboutText: about,
            onSendMessagePressed: () {},
            onStartChatPressed: () {},
            myProfile: false,
          ),
        );
      default:
        return SliverToBoxAdapter(
          child: Text('User not found'),
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
              child: userInfoFuture == null
                  ? Container(
                      alignment: Alignment.center,
                      constraints: BoxConstraints(
                        maxWidth: 50.0,
                        maxHeight: 200.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.blue),
                            backgroundColor: Colors.grey,
                            strokeWidth: 3,
                          ),
                          SizedBox(height: 8),
                          Text('Loading'),
                        ],
                      ),
                    )
                  : ProfileHeader(
                      backgroundImage: background,
                      profilePicture: profilePicture,
                      backgroundImageFile : backgroundImageFile,
                      profileImageFile : profileImageFile,
                      username: displayName,
                      userinfo: userinfo,
                      about: about,
                      myProfile: true,
                      followed: followStatus!,
                      follow : unfollowOrFollow,
                      onStartChatPressed: () => {},
                      editprofile: () => navigateToEditProfile(context),
                      socialMediaLinks: socialMediaLinks,
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