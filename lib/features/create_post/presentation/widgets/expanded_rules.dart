import 'package:flutter/material.dart';

class ExpandableListWidget extends StatefulWidget {
  final String text;
  final List<String> itemList;

  const ExpandableListWidget({
    required this.text,
    required this.itemList,
  });

  @override
  _ExpandableListWidgetState createState() => _ExpandableListWidgetState();
}

class _ExpandableListWidgetState extends State<ExpandableListWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 24,
              ),
            ],
          ),
        ),
        if (_isExpanded)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.itemList.map((item) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(item),
              );
            }).toList(),
          ),
      ],
    );
  }
}
