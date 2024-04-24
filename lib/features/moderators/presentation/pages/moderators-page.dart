import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/custom_bar.dart';
import 'package:spreadit_crossplatform/features/moderators/data/get_moderators.dart';
import 'package:spreadit_crossplatform/features/moderators/data/moderator_class_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';
import '../../../homepage/presentation/widgets/date_to_duration.dart';

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
    //fetchModerators();
    ModeratorsList = fetchModeratorsData(widget.communityName, _selectedIndex);
  }

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /*Future<void> fetchModerators() async {
    try {
      var data = await fetchModeratorsData(communityName, selectedIndex);
      setState(() {
       ModeratorsList = data;
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }*/

  void removeModeratorFromList(Moderator moderator) {
    setState(() {
      ModeratorsList.remove(moderator);
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
                    leading: CircleAvatar(
                        foregroundImage: NetworkImage(e.profilepic)),
                    title: Text(e.username,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    subtitle: Row(children: [
                      Text(dateToDuration(e.moderatorSince)),
                      e.isFullPermissions
                          ? Text('   .Full permissions')
                          : e.isAccess && e.isPosts
                              ? Text('   .Access, Posts')
                              : e.isAccess
                                  ? Text("   .Access")
                                  : e.isPosts
                                      ? Text('   .Posts')
                                      : Text(""),
                    ]),
                    onTap: () {});
              }).toList()),
        );
      case 1:
        return SliverToBoxAdapter(
          child: ListView(
              shrinkWrap: true,
              children: ModeratorsList.map((e) {
                return ListTile(
                  leading:
                      CircleAvatar(foregroundImage: NetworkImage(e.profilepic)),
                  title: Text(e.username,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  subtitle: Row(children: [
                    Text(dateToDuration(e.moderatorSince)),
                    e.isFullPermissions
                        ? Text('   .Full permissions')
                        : e.isAccess && e.isPosts
                            ? Text('   .Access, Posts')
                            : e.isAccess
                                ? Text("   .Access")
                                : e.isPosts
                                    ? Text('   .Posts')
                                    : Text(""),
                  ]),
                  onTap: () {
                    //navigate to user profile
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
                              //if (e.username != UserSingleton().user!.username)
                              if (e.username != "rehab")
                                () {
                                  //navigate to edit permissions page
                                },
                              () {
                                // navigate to user profile
                              },
                              () {
                                removeModeratorFromList(e);
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
                      CircleAvatar(foregroundImage: NetworkImage(e.profilepic)),
                  title: Text(e.username,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  subtitle: Row(children: [
                    Text(dateToDuration(e.moderatorSince)),
                    e.isFullPermissions
                        ? Text('     .Full permissions')
                        : e.isAccess && e.isPosts
                            ? Text('    .Access, Posts')
                            : e.isAccess
                                ? Text("  .Access")
                                : e.isPosts
                                    ? Text('  .Posts')
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
            onPressed: () {
              // search
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // invite to moderate
            },
          ),
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
