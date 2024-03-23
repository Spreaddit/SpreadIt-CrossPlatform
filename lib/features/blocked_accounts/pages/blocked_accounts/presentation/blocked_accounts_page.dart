import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/data/get_blocked_accounts.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/data/put_blocked_accounts.dart';

class BlockedAccountsPage extends StatefulWidget {
  const BlockedAccountsPage({Key? key}) : super(key: key);
  @override
  State<BlockedAccountsPage> createState() {
    return _BlockedAccountsPageState();
  }
}

class _BlockedAccountsPageState extends State<BlockedAccountsPage> {
  List<dynamic> blockedAccountsList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    var data = await getBlockedAccounts();
    setState(() {
      blockedAccountsList = data;
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: SettingsAppBar(title: "Blocked Accounts"),
      body: blockedAccountsList.isEmpty
          ? Center(
              child: Image.asset('assets/images/Empty_Toast.png', width: 200))
          : ListView(
              shrinkWrap: true,
              children: blockedAccountsList.map((e) {
                print(e['icon']);
                return ListTile(
                  leading:
                      CircleAvatar(foregroundImage: NetworkImage(e['icon'])),
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
                      updateBlockedAccounts(updatedList: blockedAccountsList);
                    },
                    child: Text('Unblock'),
                  ),
                );
              }).toList()),
    );
  }
}
