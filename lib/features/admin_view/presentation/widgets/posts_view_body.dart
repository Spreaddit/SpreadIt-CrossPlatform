import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/admin_view/data/ban_user_service.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/post_caard.dart';

class PostsViewBody extends StatefulWidget {
  @override
  _PostsViewBodyState createState() => _PostsViewBodyState();
}

class _PostsViewBodyState extends State<PostsViewBody> {
  DateTime getBanDuration(String banDuration) {
    switch (banDuration) {
      case '1 day':
        return DateTime.now().add(Duration(days: 1));
      case '1 week':
        return DateTime.now().add(Duration(days: 7));
      case '1 month':
        return DateTime.now().add(Duration(days: 30));
      case '3 months':
        return DateTime.now().add(Duration(days: 90));
      case '6 months':
        return DateTime.now().add(Duration(days: 180));
      case 'Permanent':
        return DateTime.now();
      default:
        return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    final posts = ['Post 1', 'Post 2', 'Post 3'];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            PostCard(
              post: Post(
                postId: '1',
                userId: '1',
                username: 'username',
                userProfilePic: 'userProfilePic',
                votesUpCount: 1,
                votesDownCount: 1,
                sharesCount: 1,
                commentsCount: 1,
                numberOfViews: 1,
                date: DateTime.now(),
                title: 'title',
                content: ['content'],
                community: 'community',
                type: 'type',
                pollOptions: [],
                pollVotingLength: 'pollVotingLength',
                pollExpiration: DateTime.now(),
                isPollEnabled: true,
                link: 'link',
                attachments: [],
                comments: [],
                hiddenBy: [],
                votedUsers: [],
                isSpoiler: true,
                isCommentsLocked: true,
                isNsfw: true,
                sendPostReplyNotification: true,
                isSaved: true,
              ),
              comments: [],
              isUserProfile: false,
            ),
            Text('Report Reason: '),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String? _banReason;
                    String? _banDuration;

                    return AlertDialog(
                      title: Text('Ban User'),
                      content: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              _banReason = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Ban Reason',
                            ),
                          ),
                          DropdownButton<String>(
                            value: _banDuration,
                            hint: Text('Select Ban Duration'),
                            items: <String>[
                              '1 day',
                              '1 week',
                              '1 month',
                              '3 months',
                              '6 months',
                              'Permanent'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _banDuration = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Ban'),
                          onPressed: () {
                            if (_banDuration == 'Permanent') {
                              BanUserService().banUser(
                                username: "username",
                                reason: _banReason!,
                                isPermanent: true,
                              );
                            } else {
                              BanUserService().banUser(
                                username: "username",
                                reason: _banReason!,
                                banDuration: getBanDuration(_banDuration!),
                                isPermanent: false,
                              );
                            }
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red, // This makes the button red
              ),
              child: Text('Ban User'),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
