import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_approved_users.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/approved_user_card.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/icon_adding_appbar.dart';

class ApprovedUsersPage extends StatefulWidget {
  ApprovedUsersPage({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

  @override
  State<ApprovedUsersPage> createState() => _ApprovedUsersPageState();
}

class _ApprovedUsersPageState extends State<ApprovedUsersPage> {
  Future<List<dynamic>>? _approvedUsersData;
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
    _approvedUsersData = getApprovedUsersRequest(widget.communityName);
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
      backgroundColor: Colors.grey[200],
      appBar: IconAddingAppBar(
        title: 'Approved Users',
        communityName: widget.communityName,
        isApproving: true,
        onRequestCompleted: () => setState(() {
          fetchData();
        }),
      ),
      body: FutureBuilder(
        future: _approvedUsersData,
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
                        return ApprovedUserCard(
                          username: _filteredData[index]['username'],
                          avatarUrl: _filteredData[index]['avatar'],
                          banner: _filteredData[index]['banner'],
                          onUnApprove: () => setState(() {
                            fetchData();
                          }),
                          communityName: widget.communityName,
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
