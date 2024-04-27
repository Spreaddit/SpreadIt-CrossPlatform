import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_banned_users.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/add_data_appbar.dart';

class AddOrEditBanned extends StatefulWidget {
  AddOrEditBanned(
      {Key? key, required this.communityName, required this.isAdding})
      : super(key: key);

  /// The name of the community
  final String communityName;

  /// true if adding, false if editing
  final bool isAdding;

  @override
  State<AddOrEditBanned> createState() => _AddOrEditBannedState();
}

class _AddOrEditBannedState extends State<AddOrEditBanned> {
  bool isAdding = false;
  bool hasEnteredEnoughData = false;
  String userName = '';
  int days = -1;
  String banReason = '';
  String messageToUser = '';
  Future<List<Map<String, dynamic>>>? _bannedUsersData;

  @override
  void initState() {
    super.initState();
    isAdding = widget.isAdding;
    if (!isAdding) {
      fetchData();
    }
  }

  void fetchData() async {}

  void addBannedUser() async {
    int response = await banUserRequest(
        communityName: widget.communityName,
        userName: userName,
        violation: "",
        days: days,
        banReason: banReason,
        messageToUser: messageToUser);
    if (response == 200) {
      Navigator.pop(context);
      CustomSnackbar(content: "User banned!").show(context);
    } else {
      CustomSnackbar(content: "Error banning user").show(context);
    }
  }

  void editBannedUser() async {
    int response = await editBannedUserRequest(
        communityName: widget.communityName,
        userName: userName,
        violation: "",
        days: days,
        banReason: banReason,
        messageToUser: messageToUser);
    if (response == 200) {
      Navigator.pop(context);
      CustomSnackbar(content: "User ban edited!").show(context);
    } else {
      CustomSnackbar(content: "Error editing ban").show(context);
    }
  }

  InputDecoration getTextFieldDecoration(String? hintText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      border: OutlineInputBorder(),
      hintText: hintText,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isAdding) {
      FutureBuilder(
        future: _bannedUsersData,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
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
            return pageData();
          } else {
            CustomSnackbar(content: "Unknown error fetching data")
                .show(context);
            return Text("");
          }
        },
      );
    }
    return pageData();
  }

  Widget pageData() {
    return Scaffold(
      appBar: AddingDataAppBar(
        title: isAdding ? 'Add a banned user' : 'Edit banned user',
        onSavePressed: hasEnteredEnoughData
            ? () {
                if (isAdding) {
                  // Add user
                } else {
                  // Edit user
                }
              }
            : null,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Username'),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    decoration: getTextFieldDecoration("Username"),
                    readOnly: !isAdding,
                    onChanged: (value) {
                      setState(() {
                        userName = value;
                        hasEnteredEnoughData =
                            userName.isNotEmpty && banReason.isNotEmpty;
                      });
                    },
                  ),
                ),
              ),
              Text('Reason for ban'),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    decoration: getTextFieldDecoration("Pick a reason"),
                    onChanged: (value) {
                      setState(() {
                        banReason = value;
                        hasEnteredEnoughData =
                            userName.isNotEmpty && banReason.isNotEmpty;
                      });
                    },
                  ),
                ),
              ),
              Text('How Long?'),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
                      child: TextField(
                        decoration: getTextFieldDecoration(null),
                        onChanged: (value) {
                          setState(() {
                            if (value == '') {
                              days = -1;
                              return;
                            }
                            days = int.parse(value);
                          });
                        },
                      ),
                    ),
                  ),
                  Text('Days'),
                  SizedBox(
                    width: 16,
                  ),
                  Checkbox(
                    value: days == -1,
                    onChanged: (value) {
                      setState(() {
                        days = -1;
                      });
                    },
                  ),
                  Text('Permanent',
                      style: TextStyle(fontWeight: FontWeight.w800)),
                ],
              ),
              Text('Note to be included in ban message'),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    maxLines: null,
                    minLines: 4,
                    decoration: getTextFieldDecoration(
                        "The user will receive this note in a message"),
                    onChanged: (value) {
                      setState(() {
                        banReason = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
