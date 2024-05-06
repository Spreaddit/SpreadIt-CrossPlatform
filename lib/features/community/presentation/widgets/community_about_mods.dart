import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_moderators_data.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/pages/user_profile.dart';

class CommunityAboutMods extends StatefulWidget {
  CommunityAboutMods({Key? key, required this.communityName, required this.modData}) : super(key: key);

  final String communityName;
  final List<dynamic> modData;

  @override
  State<CommunityAboutMods> createState() => _CommunityAboutModsState();
}

class _CommunityAboutModsState extends State<CommunityAboutMods> {
  Future<List<dynamic>>? modDataFuture;
  List<dynamic> modData = [];

  @override
  void initState() {
    super.initState();
    modData = widget.modData;
    //fetchData();
  }

  void fetchData() async {
    modDataFuture = getModeratorsRequest(widget.communityName);
  }

  void navigateToMessagingPage() {
    //TODO implement this W/FARIDA
  }

  void navigateToModeratorProfile(String username) {
    //TODO implement nav to user W/MARIAM

    Navigator.of(context).push(
      MaterialPageRoute(
        settings: RouteSettings(
          name: '/user-profile/$username',
        ),
        builder: (context) => UserProfile(
          username: username,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Moderators",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.email_outlined),
                    onPressed: () => navigateToMessagingPage(),
                  ),
                ),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: modData.length,
                  itemBuilder: (context, index) {
                    return TextButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                      onPressed: () => navigateToModeratorProfile(
                          modData[index]['username']),
                      child: ListTile(
                        title: Text("u/${modData[index]['username']}"),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
