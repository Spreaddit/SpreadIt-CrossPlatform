import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/widgets/users_list.dart';

class ChatUserPage extends StatefulWidget {
  final int selectedOption;
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
