import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_moderators_data.dart';

class CommunityAboutMods extends StatefulWidget {
  CommunityAboutMods({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

  @override
  State<CommunityAboutMods> createState() => _CommunityAboutModsState();
}

class _CommunityAboutModsState extends State<CommunityAboutMods> {
  Future<List<dynamic>>? modData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    modData = getModeratorsRequest(widget.communityName);
  }

  void navigateToMessagingPage() {
    //TODO implement this W/FARIDA
  }

  void navigateToModeratorProfile(String username) {
    //TODO implement this W/MARIAM
    Navigator.of(context).pushNamed(
      '/user-profile',
      arguments: {
        'username': username,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: modData,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrangeAccent,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error fetching data 😔"));
        } else if (snapshot.hasData) {
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
                  itemCount: snapshot.data!.length,
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
                          snapshot.data![index]['username']),
                      child: ListTile(
                        title: Text("u/${snapshot.data![index]['username']}"),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(child: Text("Unknown error fetching data 🤔"));
        }
      },
    );
  }
}
