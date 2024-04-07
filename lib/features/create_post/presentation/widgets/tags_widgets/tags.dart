import 'package:flutter/material.dart';

class Tag extends StatefulWidget {

  final String tagName;
  final String tagDescription;
  final Icon tagIcon;
  final bool tagValue;
  final ValueChanged<bool>? onChanged;

  const Tag({
    required this.tagName,
    required this.tagDescription,
    required this.tagIcon,
    required this.tagValue,
    this.onChanged,
  });

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {

  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  widget.tagIcon,
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.tagName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      Text(widget.tagDescription),
                    ],
                    ),
                  Spacer(),
                  Switch(
                    value: widget.tagValue,
                    onChanged: widget.onChanged,
                    activeColor: Colors.blue,
                    ), 
                ],
                ),
            );
  }
}