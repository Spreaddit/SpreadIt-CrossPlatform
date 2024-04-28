import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_banned_users.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/banned_user_card.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/icon_adding_appbar.dart';

class BannedUsersPage extends StatefulWidget {
  BannedUsersPage({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

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

  void fetchData() async {
    _bannedUsersData = getBannedUsersRequest(widget.communityName);
  }

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
      appBar: IconAddingAppBar(
        title: 'Banned Users',
        communityName: widget.communityName,
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
            CustomSnackbar(content: "Error fetching data").show(context);
            return Text('');
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
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: _filteredData.length,
                      separatorBuilder: (context, index) => Divider(),
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return BannedUserCard(
                          username: _filteredData[index]['username'],
                          communityName: widget.communityName,
                          violation: _filteredData[index]['violation'],
                          banReason: _filteredData[index]['banReason'],
                          days: _filteredData[index]['days'],
                          messageToUser: _filteredData[index]['messageToUser'],
                          bannedDate: _filteredData[index]['bannedDate'],
                          avatarUrl: _filteredData[index]['avatar'],
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
            CustomSnackbar(content: "Unknown error fetching data")
                .show(context);
            return Text("");
          }
        },
      ),
    );
  }
}
