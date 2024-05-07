import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_approved_users.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/add_data_appbar.dart';

/// A page for adding approved users to a community.
class AddApprovedPage extends StatefulWidget {
  /// Constructs a new instance of AddApprovedPage.
  ///
  /// [key] is an optional key to identify this widget.
  /// [communityName] is the name of the community to which the user will be added.
  /// [onRequestCompleted] is a callback function to be executed when the user addition request is completed.
  const AddApprovedPage({
    Key? key,
    required this.communityName,
    required this.onRequestCompleted,
  }) : super(key: key);

  /// The name of the community.
  final String communityName;

  /// A callback function to be executed when the user addition request is completed.
  final Function onRequestCompleted;

  @override
  State<AddApprovedPage> createState() => _AddApprovedPageState();
}

/// The state associated with AddApprovedPage.
class _AddApprovedPageState extends State<AddApprovedPage> {
  final TextEditingController _usernameController = TextEditingController();

  /// Adds an approved user to the community.
  Future<void> addApprovedUser() async {
    final response = await approveUserRequest(
      communityName: widget.communityName,
      username: _usernameController.text,
    );
    if (response == 200) {
      CustomSnackbar(content: 'u/${_usernameController.text} was approved').show(context);
      widget.onRequestCompleted();
      Navigator.pop(context);
    } else {
      CustomSnackbar(content: 'Failed to approve user').show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AddOrSaveDataAppBar(
        title: 'Add Approved User',
        actionText: 'Add',
        onButtonPressed: _usernameController.text.isNotEmpty ? () => addApprovedUser() : null,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Username'),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(),
                      hintText: "username",
                      prefixStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                      prefixText: "u/",
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'This user will be able to submit content to your community.',
                  softWrap: true,
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
