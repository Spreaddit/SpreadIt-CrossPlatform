import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_bar.dart';
import 'package:spreadit_crossplatform/features/moderators/data/delete_moderator.dart';
import 'package:spreadit_crossplatform/features/moderators/data/get_moderators.dart';
import 'package:spreadit_crossplatform/features/moderators/data/moderator_class_model.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/pages/edit_moderators_permissions.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import '../../../homepage/presentation/widgets/date_to_duration.dart';
import 'package:spreadit_crossplatform/features/moderators/presentation/widgets/invitation_to_moderate.dart';

List<Map<String, String>> communities = [
  {
    'name': 'Icon 1',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  {
    'name': 'Icon 2',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  {
    'name': 'Icon 3',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  {
    'name': 'Icon 4',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  {
    'name': 'Icon 5',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  {
    'name': 'Icon 6',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  {
    'name': 'Icon 7',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  {
    'name': 'Icon 8',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  {
    'name': 'Icon 9',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  {
    'name': 'Icon 10',
    'url':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAMWde6OBJPo8xsyjX6g0HoNv_V3jmwObQ2cMNOam4Ww&s',
  },
  // Add more icons as needed
];

class ModeratorsPage extends StatefulWidget {
  final String communityName;
  const ModeratorsPage({required this.communityName});

  @override
  State<ModeratorsPage> createState() {
    return _ModeratorsPageState();
  }
}

class _ModeratorsPageState extends State<ModeratorsPage> {
  bool isModerator = true;
  int _selectedIndex = 0;
  List<Moderator> ModeratorsList = [];
  @override
  void initState() {
    super.initState();
    fetchModerators();
    //ModeratorsList = fetchModeratorsData(widget.communityName, _selectedIndex);
  }

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
      fetchModerators();
    });
  }

  void onPermissionsChanged(bool newManagePostAndComments, bool newManageUsers,
      bool newMnageSettings) {
    setState(() {});
  }

  Future<void> fetchModerators() async {
    try {
      var data =
          await fetchModeratorsData(widget.communityName, _selectedIndex);
      print(data);
      setState(() {
        ModeratorsList = data;
      });
    } catch (e) {
      print('Error fetching moderators: $e');
    }
  }

  void removeModeratorFromList(Moderator moderator) {
    setState(() {
      ModeratorsList.remove(moderator);
      deleteModerator(widget.communityName, moderator.username);
    });
  }

  Widget _buildSelectedPage() {
    print('build');
    print("_selectedIndexxx: $_selectedIndex");
    switch (_selectedIndex) {
      case 0: //all moderators case
        return SliverToBoxAdapter(
          child: ListView(
              shrinkWrap: true,
              children: ModeratorsList.map((e) {
                return ListTile(
                    leading:
                        CircleAvatar(foregroundImage: NetworkImage(e.avatar)),
                    title: Text(e.username,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    subtitle: Row(children: [
                      Text(dateToDuration(e.moderationDate)),
                      e.managePostsAndComments &&
                              e.manageSettings &&
                              e.manageUsers
                          ? Text(
                              '   .Manage posts and comments, Manage settings, Manage users')
                          : e.managePostsAndComments && e.manageSettings
                              ? Text(
                                  '   .Manage posts and comments, Manage settings')
                              : e.managePostsAndComments && e.manageUsers
                                  ? Text(
                                      '   .Manage posts and comments, Manage users')
                                  : e.manageSettings && e.manageUsers
                                      ? Text(
                                          '   .Manage settings, Manage users')
                                      : e.managePostsAndComments
                                          ? Text(
                                              '   .Manage posts and comments')
                                          : e.manageSettings
                                              ? Text('   .Manage settings')
                                              : e.manageUsers
                                                  ? Text('   .Manage users')
                                                  : Text(""),
                    ]),
                    onTap: () {});
              }).toList()),
        );
      case 1: //editable moderators
        return SliverToBoxAdapter(
          child: ListView(
              shrinkWrap: true,
              children: ModeratorsList.map((e) {
                void onPermissionsChanged(bool newManagePostAndComments,
                    bool newManageUsers, bool newManageSettings) {
                  setState(() {
                    e.managePostsAndComments = newManagePostAndComments;
                    e.manageUsers = newManageUsers;
                    e.manageSettings = newManageSettings;
                  });
                }

                return ListTile(
                  leading:
                      CircleAvatar(foregroundImage: NetworkImage(e.avatar)),
                  title: Text(e.username,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  subtitle: Row(children: [
                    Text(dateToDuration(e.moderationDate)),
                    e.managePostsAndComments &&
                            e.manageSettings &&
                            e.manageUsers
                        ? Text(
                            '   .Manage posts and comments, Manage settings, Manage users')
                        : e.managePostsAndComments && e.manageSettings
                            ? Text(
                                '   .Manage posts and comments, Manage settings')
                            : e.managePostsAndComments && e.manageUsers
                                ? Text(
                                    '   .Manage posts and comments, Manage users')
                                : e.manageSettings && e.manageUsers
                                    ? Text('   .Manage settings, Manage users')
                                    : e.managePostsAndComments
                                        ? Text('   .Manage posts and comments')
                                        : e.manageSettings
                                            ? Text('   .Manage settings')
                                            : e.manageUsers
                                                ? Text('   .Manage users')
                                                : Text(""),
                  ]),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      '/user-profile',
                      arguments: {
                        'username': e.username,
                      },
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert_rounded),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomBottomSheet(
                            icons: [
                              //if (e.username != UserSingleton().user!.username)
                              if (e.username != "rehab") Icons.edit,
                              Icons.person,
                              Icons.block
                            ],
                            text: [
                              //if (e.username != UserSingleton().user!.username)
                              if (e.username != "rehab") "Edit Permissions",
                              "View profile",
                              "Remove"
                            ],
                            onPressedList: [
                              // if (e.username != UserSingleton().user!.username)
                              if (e.username != "rehab")
                                () {
                                  //navigate to edit permissions page

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditPermissionsPage(
                                        communityName: widget.communityName,
                                        username: e.username,
                                        managePostsAndComments:
                                            e.managePostsAndComments,
                                        manageUsers: e.manageUsers,
                                        manageSettings: e.manageSettings,
                                        onPermissionsChanged:
                                            onPermissionsChanged,
                                      ),
                                    ),
                                  );
                                },
                              () {
                                Navigator.of(context).pushNamed(
                                  '/user-profile',
                                  arguments: {
                                    'username': e.username,
                                  },
                                );
                              },
                              () {
                                removeModeratorFromList(e);
                                Navigator.pop(context);
                              }
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              }).toList()),
        );
      default:
        return SliverToBoxAdapter(
          child: ListView(
              shrinkWrap: true,
              children: ModeratorsList.map((e) {
                return ListTile(
                  leading:
                      CircleAvatar(foregroundImage: NetworkImage(e.avatar)),
                  title: Text(e.username,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  subtitle: Row(children: [
                    Text(dateToDuration(e.moderationDate)),
                    e.managePostsAndComments &&
                            e.manageSettings &&
                            e.manageUsers
                        ? Text(
                            '   .Manage posts and comments, Manage settings, Manage users')
                        : e.managePostsAndComments && e.manageSettings
                            ? Text(
                                '   .Manage posts and comments, Manage settings')
                            : e.managePostsAndComments && e.manageUsers
                                ? Text(
                                    '   .Manage posts and comments, Manage users')
                                : e.manageSettings && e.manageUsers
                                    ? Text('   .Manage settings, Manage users')
                                    : e.managePostsAndComments
                                        ? Text('   .Manage posts and comments')
                                        : e.manageSettings
                                            ? Text('   .Manage settings')
                                            : e.manageUsers
                                                ? Text('   .Manage users')
                                                : Text(""),
                  ]),
                  onTap: () {
                    //navigate to user profile
                  },
                );
              }).toList()),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moderators'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Map<String, String>? _selectedCommunity;
                bool _managePostsClicked = false;
                bool _manageUsersClicked = false;
                bool _manageSettingsClicked = false;

                late TextEditingController _messageController;

                @override

                /*void initState() {
                _messageController =
                    TextEditingController(text: 'Initial Value');
              }*/

                void dispose() {
                  _messageController.dispose();
                }

                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Choose a community:',
                                style: TextStyle(fontSize: 20.0),
                              ),
                              SizedBox(height: 16.0),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: communities.map((community) {
                                    bool isSelected =
                                        _selectedCommunity == community;
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedCommunity = community;
                                            _messageController =
                                                TextEditingController(
                                                    text:
                                                        'I invite you to be a moderator of r/${community["name"]} ');
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: isSelected
                                                  ? Colors.blue
                                                  : Colors.transparent,
                                              backgroundImage: NetworkImage(
                                                  community['url']!),
                                              child: CircleAvatar(
                                                radius: isSelected ? 25 : 30,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                    community['url']!),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? Colors.blue
                                                          : Colors.transparent,
                                                      width: isSelected
                                                          ? 4.0
                                                          : 0.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 8.0),
                                            Text(community['name']!),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              if (_selectedCommunity != null) ...[
                                /* Text(
                                'Selected Community: ${_selectedCommunity!['name']}',
                                style: TextStyle(fontSize: 16.0),
                              ),*/
                                SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _managePostsClicked =
                                              !_managePostsClicked;
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                          (states) {
                                            return _managePostsClicked
                                                ? Colors.blue
                                                : Colors.grey;
                                          },
                                        ),
                                      ),
                                      child: Text('Manage posts and comments'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _manageUsersClicked =
                                              !_manageUsersClicked;
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                          (states) {
                                            return _manageUsersClicked
                                                ? Colors.blue
                                                : Colors.grey;
                                          },
                                        ),
                                      ),
                                      child: Text('Manage users'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _manageSettingsClicked =
                                              !_manageSettingsClicked;
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                          (states) {
                                            return _manageSettingsClicked
                                                ? Colors.blue
                                                : Colors.grey;
                                          },
                                        ),
                                      ),
                                      child: Text('Manage settings'),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller:
                                            _messageController, // Set controller here
                                        onChanged: (value) {
                                          setState(
                                              () {}); // Update UI when text changes
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Type your message here...',
                                          labelText: 'Message',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    ElevatedButton.icon(
                                      onPressed: _messageController
                                              .text.isNotEmpty
                                          ? () {
                                              print(_messageController.text);
                                              print(_managePostsClicked);
                                              print(_manageUsersClicked);
                                              print(_manageSettingsClicked);
                                              print(
                                                  _selectedCommunity!["name"]);
                                              //TODO: send invitation api by sending these parameters
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text('Invitation sent!'),
                                                ),
                                              );
                                            }
                                          : null,
                                      icon: Icon(Icons.send),
                                      label: Text('Send'),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          return _messageController
                                                  .text.isNotEmpty
                                              ? Colors.blue
                                              : Colors.grey;
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              }),
        ],
      ),
      body: Container(
        color: _selectedIndex == 1 ? Colors.grey[200] : Colors.transparent,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomBar(
                tabs: ['All', 'Editable'],
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
