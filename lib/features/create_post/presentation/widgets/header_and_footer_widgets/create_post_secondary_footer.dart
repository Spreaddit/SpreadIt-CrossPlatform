import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'secondary_footer_icon.dart';

class SecondaryPostFooter extends StatefulWidget {

  final VoidCallback onLinkPress;
  final VoidCallback onImagePress;
  final VoidCallback onVideoPress;
  final VoidCallback onPollPress;
  final IconData? lastPressedIcon; 
  final Function(IconData?) setLastPressedIcon;

  const SecondaryPostFooter({
    required this.onLinkPress,
    required this.onImagePress,
    required this.onVideoPress,
    required this.onPollPress,
    required this.lastPressedIcon,
    required this.setLastPressedIcon,
  });

  @override
  State<SecondaryPostFooter> createState() => _SecondaryPostFooterState();
}

class _SecondaryPostFooterState extends State<SecondaryPostFooter> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(bottom: 12),
      child: Column(
        children:[ 
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              widget.lastPressedIcon == null ? 'What do you want to add?' : 'You can add one type of attachments for now',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              ),
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SecondaryFooterIcon(
              icon: Icons.attachment_rounded,
              text: 'Link',
              onPressed: () {
                widget.onLinkPress.call();
                widget.setLastPressedIcon(Icons.attachment_rounded);
              },
              isDisabled: widget.lastPressedIcon != null && widget.lastPressedIcon != Icons.attachment_rounded,
              ),
            SecondaryFooterIcon(
              icon: Icons.photo,
              text: 'Image',
              onPressed: () {
                widget.onImagePress.call();
                widget.setLastPressedIcon(Icons.photo);
              },
              isDisabled: widget.lastPressedIcon != null && widget.lastPressedIcon != Icons.photo,
              ),
            SecondaryFooterIcon(
              icon: Icons.ondemand_video_rounded,
              text: 'Video',
              onPressed: () {
                widget.onVideoPress.call();
                widget.setLastPressedIcon(Icons.ondemand_video_rounded);
              },
              isDisabled: widget.lastPressedIcon != null && widget.lastPressedIcon != Icons.ondemand_video_rounded,
              ),
            SecondaryFooterIcon(
              icon: Icons.poll,
              text: 'Poll',
              onPressed: () {
                widget.onPollPress.call();
                widget.setLastPressedIcon(Icons.poll);
              },
              isDisabled: widget.lastPressedIcon != null && widget.lastPressedIcon != Icons.poll,
              ), 
          ],
          ),
        ],
      ),
    );
  }
}

/* TODO
1) el action bta3 kol icon
2) el api bta3 el actions di */