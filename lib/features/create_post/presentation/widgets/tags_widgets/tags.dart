import 'package:flutter/material.dart';


/// [Tag] : a class which renders each tag selection switch 
/// Parameters :
/// 1) [tagName] : the name of the tag (Spoiler or NSFW)
/// 2) [tagDescription] : teh description of each tag's meaning 
/// 3) [tagIcon] : the icon to e displayed next to the tag
/// 4) [tagValue] : a boolean to indicate if the flag is set 
/// 5) [onChanged] : toggle the flag when the switch is pressed

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