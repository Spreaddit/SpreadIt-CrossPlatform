import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/footer_icon.dart';

class PostFooter extends StatefulWidget {
  final VoidCallback toggleFooter;

  const PostFooter({
    required this.toggleFooter,
  });

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          FooterIcon(
            icon: Icons.attachment_rounded,
            onPressed: () {}
            ),
          FooterIcon(
            icon: Icons.photo,
            onPressed: () {}
            ),
          FooterIcon(
            icon: Icons.ondemand_video_rounded,
            onPressed: () {}
            ),
          FooterIcon(
            icon: Icons.poll,
            onPressed: () {}
            ),
          Expanded(
            child:Padding(
              padding: EdgeInsets.only(right:15),
              child: Align(
                alignment: Alignment.centerRight,
                child: FooterIcon(
                  icon: Icons.keyboard_arrow_down,
                  onPressed: widget.toggleFooter,
                  ),
              ),
            ),
          ),
        ],
        ),
    );
  }
}

/* TODO
1) el action bta3 kol icon
2) el api bta3 el actions di */