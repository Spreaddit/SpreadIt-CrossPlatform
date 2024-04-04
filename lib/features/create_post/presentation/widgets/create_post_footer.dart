import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/footer_icon.dart';

class PostFooter extends StatefulWidget {
  final VoidCallback? toggleFooter;
  final bool showAttachmentIcon;
  final bool showPhotoIcon;
  final bool showVideoIcon;
  final bool showPollIcon;

  const PostFooter({
    required this.toggleFooter,
    required this.showAttachmentIcon,
    required this.showPhotoIcon,
    required this.showVideoIcon,
    required this.showPollIcon,
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          if(widget.showAttachmentIcon) 
            FooterIcon(
              icon: Icons.attachment_rounded,
              onPressed: () {}
              ),
          if(widget.showPhotoIcon)    
            FooterIcon(
              icon: Icons.photo,
              onPressed: () {}
              ),
          if(widget.showVideoIcon)    
            FooterIcon(
              icon: Icons.ondemand_video_rounded,
              onPressed: () {}
              ),
          if(widget.showPollIcon)    
            FooterIcon(
              icon: Icons.poll,
              onPressed: () {}
              ),
          if(widget.toggleFooter != null)    
            Expanded(
              child:Padding(
                padding: EdgeInsets.only(right:15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FooterIcon(
                    icon: Icons.keyboard_arrow_down,
                    onPressed: widget.toggleFooter!,
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