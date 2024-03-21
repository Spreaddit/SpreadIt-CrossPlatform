import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/features/pages/blocked_accounts/data/get_data.dart';
import 'package:spreadit_crossplatform/features/pages/blocked_accounts/data/put_data.dart';

//testing data//
List blockedUsers = [
  {
    'name': 'rehab',
    'icon': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
  },
  {
    'name': 'mimo',
    'icon': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'
  },
  {
    'name': 'fofa',
    'icon': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png'
  }
];

class BlockedAccountsPage extends StatefulWidget {
  const BlockedAccountsPage({Key? key}) : super(key: key);
  @override
  State<BlockedAccountsPage> createState() {
    return _BlockedAccountsPageState();
  }
}

class _BlockedAccountsPageState extends State<BlockedAccountsPage> {
  //Data Membere//
  List<dynamic> blockedAccountsList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    var data = await getData(); // Await the result of getData()
    setState(() {
      blockedAccountsList =
          data; // Update blockedAccountsList with fetched data
    });
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Blocked Accounts',
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: blockedAccountsList.isEmpty
          ? Center(
              child: Image.asset('assets/images/Empty_Toast.png', width: 200))
          : ListView(
              shrinkWrap: true, //blockedUsers.map((e)
              children: blockedAccountsList.map((e) {
                return ListTile(
                  /*leading: CircleAvatar(foregroundImage: NetworkImage(e['icon'])),*/
                  title: Text(e['name'],
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  trailing: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        blockedAccountsList.remove(e);
                      });
                      updateData(updatedList: blockedAccountsList);
                    },
                    child: Text('Unblock'),
                  ),
                );
              }).toList()),
    );
  }
}
