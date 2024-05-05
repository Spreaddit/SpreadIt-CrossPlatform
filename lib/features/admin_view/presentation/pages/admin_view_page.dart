import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/admin_view/data/ban_user_service.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import '../widgets/comments_view_body.dart';
import '../widgets/posts_view_body.dart';

/// `AdminViewPage` is a Flutter widget that represents the admin view page.
///
/// It extends the `StatefulWidget` class, which means it can maintain state that can change over time.
class AdminViewPage extends StatefulWidget {
  /// Constructs an `AdminViewPage` widget.
  AdminViewPage({Key? key}) : super(key: key);

  /// Creates the mutable state for this widget.
  @override
  _AdminViewPageState createState() => _AdminViewPageState();
}

class _AdminViewPageState extends State<AdminViewPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Admin View'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Comments'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Unban', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _unbanUser();
              },
            ),
          ]),
      body: TabBarView(
        controller: _tabController,
        children: [
          PostsViewBody(),
          CommentsViewBody(),
        ],
      ),
    );
  }

  void _unbanUser() {
    final _formKey = GlobalKey<FormState>();
    final _usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Unban User'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(hintText: 'Enter username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Unban'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String username = _usernameController.text;
                  try {
                    String message =
                        await BanUserService().unbanUser(username: username);
                    CustomSnackbar(content: message).show(context);
                  } catch (e) {
                    CustomSnackbar(content: e.toString()).show(context);
                  }
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
