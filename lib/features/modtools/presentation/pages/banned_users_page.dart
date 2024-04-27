import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_banned_users.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/icon_adding_appbar.dart';

class BannedUsersPage extends StatefulWidget {
  BannedUsersPage({Key? key, required this.communityName}) : super(key: key);

  final String communityName;

  @override
  State<BannedUsersPage> createState() => _BannedUsersPageState();
}

class _BannedUsersPageState extends State<BannedUsersPage> {
  Future<List<dynamic>>? _bannedUsersData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    _bannedUsersData = getBannedUsersRequest(widget.communityName);
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
            return Center(
              child: Text('Error fetching data'),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                key: Key('EmptyStateImage'),
                child: Image.asset('assets/images/Empty_Toast.png', width: 200),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['username']),
                    subtitle: Text(snapshot.data![index]['violation']),
                    trailing: Text(snapshot.data![index]['days'].toString()),
                  );
                },
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
