import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/admin_view/data/ban_user_service.dart';
import 'package:spreadit_crossplatform/features/admin_view/data/get_reported_comments_service.dart';
import 'package:spreadit_crossplatform/features/admin_view/data/report_data_model.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/comments.dart';

/// `CommentsViewBody` is a Flutter widget that represents the body of the comments view.
///
/// It extends the `StatefulWidget` class, which means it can maintain state that can change over time.
class CommentsViewBody extends StatefulWidget {
  /// Constructs a `CommentsViewBody` widget.
  CommentsViewBody({Key? key}) : super(key: key);

  /// Creates the mutable state for this widget.
  @override
  _CommentsViewBodyState createState() => _CommentsViewBodyState();
}

class _CommentsViewBodyState extends State<CommentsViewBody> {
  DateTime getBanDuration(String banDuration) {
    switch (banDuration) {
      case '1 day':
        return DateTime.now().add(Duration(days: 1));
      case '1 week':
        return DateTime.now().add(Duration(days: 7));
      case '1 month':
        return DateTime.now().add(Duration(days: 30));
      case '3 months':
        return DateTime.now().add(Duration(days: 90));
      case '6 months':
        return DateTime.now().add(Duration(days: 180));
      case 'Permanent':
        return DateTime.now();
      default:
        return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    final getReportedCommentsService = GetReportedCommentsService();

    return FutureBuilder<Map<String, dynamic>>(
      future: getReportedCommentsService.getReportedComments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            widthFactor: 2,
            heightFactor: 2,
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Comment> comments = snapshot.data!['comments'];
          List<List<Report>> reports = snapshot.data!['reports'];

          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              Comment comment = comments[index];
              List<Report> commentReports = reports[index];

              // Create a Set of unique report reasons
              Set<String> uniqueReportReasons = commentReports
                  .map((report) => report.reason)
                  .whereType<String>()
                  .toSet();
              return Column(
                children: [
                  CommentWidget(
                    comment: comment,
                    isUserProfile: false,
                  ),
                  ...uniqueReportReasons
                      .map((reason) => Text('Report Reason: $reason'))
                      .toList(),
                  ElevatedButton(
                    onPressed: () {
                      _banUserDialog(comment.username!);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red, // This makes the button red
                    ),
                    child: Text('Ban User'),
                  ),
                  Divider(),
                ],
              );
            },
          );
        }
      },
    );
  }

  void _banUserDialog(String username) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? _banReason;
        String? _banDuration;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Ban  u/$username'),
            content: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    _banReason = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Ban Reason',
                  ),
                ),
                DropdownButton<String>(
                  hint: Text('Select Ban Duration'),
                  value: _banDuration,
                  onChanged: (String? newValue) {
                    setState(() {
                      _banDuration = newValue;
                    });
                  },
                  items: <String>[
                    '1 day',
                    '1 week',
                    '1 month',
                    '3 months',
                    '6 months',
                    'Permanent'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Ban'),
                onPressed: () async {
                  if (_banDuration == 'Permanent') {
                    String message = await BanUserService().banUser(
                      username: username,
                      reason: _banReason!,
                      isPermanent: true,
                    );
                    CustomSnackbar(content: message).show(context);
                  } else {
                    String message = await BanUserService().banUser(
                      username: username,
                      reason: _banReason!,
                      banDuration: getBanDuration(_banDuration!),
                      isPermanent: false,
                    );
                    CustomSnackbar(content: message).show(context);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }
}
