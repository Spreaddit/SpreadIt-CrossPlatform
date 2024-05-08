import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/widgets/users_list.dart';

/// A widget representing a page for displaying a list of chat users.
///
/// This widget allows users to view a list of chat users and select one of three options:
/// - Show all users
/// - Show online users only
/// - Show offline users only
class ChatUserPage extends StatefulWidget {
  /// The selected option for filtering users.
  ///
  /// By default, all users are shown (selectedOption = 3).
  final int selectedOption;

  /// Creates a [ChatUserPage] widget.
  ///
  /// The [selectedOption] parameter specifies the initial filter option for displaying users.
  /// By default, all users are shown.
  const ChatUserPage({
    Key? key,
    this.selectedOption = 3,
  }) : super(key: key);
  @override
  State<ChatUserPage> createState() => _ChatUserPageState();
}

class _ChatUserPageState extends State<ChatUserPage> {
  late int selectedOption;
  @override
  void initState() {
    setState(() {
      selectedOption = widget.selectedOption;
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ChatUserPage oldWidget) {
    setState(() {
      selectedOption = widget.selectedOption;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print(selectedOption);
    return usersList(context: context, selectedOption: selectedOption);
  }
}
