import 'package:flutter/material.dart';

class BlockReportedUser extends StatefulWidget {
  BlockReportedUser({
    Key? key,
    required this.reportedUserName,
    required this.onValChanged,
    required this.blockIsChecked,
  }) : super(key: key);

  final String reportedUserName;
  final Function(bool) onValChanged;
  final bool blockIsChecked;

  @override
  State<BlockReportedUser> createState() => _BlockReportedUserState();
}

class _BlockReportedUserState extends State<BlockReportedUser> {
  @override
  Widget build(BuildContext context) {
    bool isChecked = widget.blockIsChecked;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          CheckboxListTile(
            value: isChecked,
            title: Text(
              "Block ${widget.reportedUserName}",
              softWrap: true,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "You won't be able to send direct messages or chat requests to each other.",
              softWrap: true,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            onChanged: (bool? newVal) {
              setState(() {
                isChecked = newVal ?? isChecked;
              });
              widget.onValChanged(isChecked);
            },
          ),
        ],
      ),
    );
  }
}
