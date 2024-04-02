import 'package:flutter/material.dart';

class Tag extends StatefulWidget {

  final String tagName;
  final String tagDescription;
  final Icon tagIcon;

  const Tag({
    required this.tagName,
    required this.tagDescription,
    required this.tagIcon,
  });

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {

  bool light = true;

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
                    value: light,
                    onChanged: (bool value) {setState(() { light = value;});},
                    activeColor: Colors.blue,
                    ), 
                ],
                ),
            );
  }
}