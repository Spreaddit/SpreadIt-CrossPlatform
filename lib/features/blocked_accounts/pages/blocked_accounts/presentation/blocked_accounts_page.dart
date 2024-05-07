import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/settings_app_bar.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/data/get_blocked_accounts.dart';
import 'package:spreadit_crossplatform/features/blocked_accounts/pages/blocked_accounts/data/put_blocked_accounts.dart';

/// Widget for displaying a list of blocked accounts with an option to unblock them.
class BlockedAccountsPage extends StatefulWidget {
  /// Constructs a 'BlockedAccountsPage'.
  const BlockedAccountsPage({Key? key}) : super(key: key);
  @override
  State<BlockedAccountsPage> createState() {
    return _BlockedAccountsPageState();
  }
}

/// State class for [BlockedAccountsPage].
class _BlockedAccountsPageState extends State<BlockedAccountsPage> {
  /// List of blocked accounts.
  List<dynamic> blockedAccountsList = [];

  @override

  /// Sets the initial state of the page.
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Fetches the list of blocked accounts from the network.
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
              key: Key('EmptyStateImage'),
              child: Image.asset('assets/images/Empty_Toast.png', width: 200))
          : ListView(
              shrinkWrap: true,
              children: blockedAccountsList.map((e) {
                print(e['avatar']);
                return ListTile(
                  leading:
                      CircleAvatar(foregroundImage: NetworkImage(e['avatar'])),
                  title: Text(e['username'],
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
