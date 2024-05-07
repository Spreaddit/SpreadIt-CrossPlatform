import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_banned_users.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/banned_user_card.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/icon_adding_appbar.dart';

/// Widget to display banned users for a community.
class BannedUsersPage extends StatefulWidget {
  /// The name of the community.
  final String communityName;

  /// Constructor for [BannedUsersPage].
  const BannedUsersPage({Key? key, required this.communityName})
      : super(key: key);

  @override
  State<BannedUsersPage> createState() => _BannedUsersPageState();
}

class _BannedUsersPageState extends State<BannedUsersPage> {
  Future<List<dynamic>>? _bannedUsersData;
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _allUsers = [];
  List<dynamic> _filteredData = [];
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// Fetches banned users data for the community.
  void fetchData() async {
    _bannedUsersData = getBannedUsersRequest(widget.communityName);
  }

  /// Filters users based on search text.
  void filterResults() {
    setState(() {
      _filteredData = (_searchController.text.isEmpty)
          ? _allUsers
          : _allUsers
              .where((element) =>
                  element['username']
                      .toLowerCase()
                      .startsWith(_searchController.text.toLowerCase()) ||
                  ("u/${element['username']}")
                      .toLowerCase()
                      .startsWith(_searchController.text.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: IconAddingAppBar(
        title: 'Banned Users',
        communityName: widget.communityName,
        isApproving: false,
        onRequestCompleted: () => setState(() {
          fetchData();
        }),
      ),
      body: FutureBuilder(
        future: _bannedUsersData,
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoaderWidget(
                dotSize: 10,
                logoSize: 100,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching data 😔"),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                key: Key('EmptyStateImage'),
                child: Image.asset('assets/images/Empty_Toast.png', width: 200),
              );
            } else {
              if (!isInitialized || _allUsers != snapshot.data!) {
                _filteredData = snapshot.data!;
                _allUsers = snapshot.data!;
                isInitialized = true;
              }
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => filterResults(),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredData.length,
                      itemBuilder: (context, index) {
                        return BannedUserCard(
                          username: _filteredData[index]['username'],
                          communityName: widget.communityName,
                          violation: _filteredData[index]['reasonForBan'],
                          banReason: _filteredData[index]['modNote'],
                          days: _filteredData[index]['days'] ?? 1,
                          messageToUser: "",
                          isPermanent: _filteredData[index]['isPermanent'],
                          endOfBanDate:
                              _filteredData[index]['isPermanent'] == false
                                  ? _filteredData[index]['banPeriod']
                                  : "2024-05-07T15:03:37.757Z",
                          avatarUrl: _filteredData[index]['userProfilePic'],
                          onRequestCompleted: () => setState(() {
                            fetchData();
                          }),
                          onUnban: () => setState(() {
                            fetchData();
                          }),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: Text("Unknown error fetching data 🤔"),
            );
          }
        },
      ),
    );
  }
}
