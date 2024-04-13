import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'footer_icon.dart';

/// [PostFooter] : the footer which contains the icons and the action to be taken when each icon is pressed

class PostFooter extends StatefulWidget {
  final VoidCallback? toggleFooter;
  final bool showAttachmentIcon;
  final bool showPhotoIcon;
  final bool showVideoIcon;
  final bool showPollIcon;
  final VoidCallback? onLinkPress;
  final VoidCallback? onImagePress;
  final VoidCallback? onVideoPress;
  final VoidCallback? onPollPress;
  final IconData? lastPressedIcon; 
  final Function(IconData?) setLastPressedIcon; 
  
  const PostFooter({
    required this.toggleFooter,
    required this.showAttachmentIcon,
    required this.showPhotoIcon,
    required this.showVideoIcon,
    required this.showPollIcon,
    this.onLinkPress,
    this.onImagePress,
    this.onVideoPress,
    this.onPollPress,
    required this.lastPressedIcon,
    required this.setLastPressedIcon,
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
              icon: Icons.link,
              onPressed: () {
                widget.onLinkPress?.call();
                widget.setLastPressedIcon(Icons.link);
              },
              isDisabled: widget.lastPressedIcon != null && widget.lastPressedIcon != Icons.link,
              ),
          if(widget.showPhotoIcon)    
            FooterIcon(
              icon: Icons.photo,
              onPressed: () {
                widget.onImagePress?.call();
                widget.setLastPressedIcon(Icons.photo);
              },
              isDisabled: widget.lastPressedIcon != null && widget.lastPressedIcon != Icons.photo,
              ),
          if(widget.showVideoIcon)    
            FooterIcon(
              icon: Icons.ondemand_video_rounded,
              onPressed: () {
                widget.onVideoPress?.call();
                widget.setLastPressedIcon(Icons.ondemand_video_rounded);
              },
              isDisabled: widget.lastPressedIcon != null && widget.lastPressedIcon != Icons.ondemand_video_rounded,
              ),
          if(widget.showPollIcon)    
            FooterIcon(
              icon: Icons.poll,
              onPressed: () {
                widget.onPollPress?.call();
                widget.setLastPressedIcon(Icons.poll);
              },
              isDisabled: widget.lastPressedIcon != null && widget.lastPressedIcon != Icons.poll,
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
                    isDisabled: false,
                    ),
                ),
              ),
            ),
        ],
        ),
    );
  }
}
