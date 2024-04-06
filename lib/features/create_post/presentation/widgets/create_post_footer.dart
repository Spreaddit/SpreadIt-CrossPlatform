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
  final VoidCallback? onLinkPress;
  final VoidCallback? onImagePress;
  final VoidCallback? onVideoPress;
  final VoidCallback? onPollPress;
  

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
  });

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {

  IconData? lastPressedIcon;

  void setLastPressedIcon (IconData passedIcon) {
    setState(() {
      lastPressedIcon = passedIcon;
    });
  }

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
              onPressed: () {
                widget.onLinkPress?.call();
                setLastPressedIcon(Icons.attachment_rounded);
              },
              isDisabled: lastPressedIcon != null && lastPressedIcon != Icons.attachment_rounded,
              ),
          if(widget.showPhotoIcon)    
            FooterIcon(
              icon: Icons.photo,
              onPressed: () {
                widget.onImagePress?.call();
                setLastPressedIcon(Icons.photo);
              },
              isDisabled: lastPressedIcon != null && lastPressedIcon != Icons.photo,
              ),
          if(widget.showVideoIcon)    
            FooterIcon(
              icon: Icons.ondemand_video_rounded,
              onPressed: () {
                widget.onVideoPress?.call();
                setLastPressedIcon(Icons.ondemand_video_rounded);
              },
              isDisabled: lastPressedIcon != null && lastPressedIcon != Icons.ondemand_video_rounded,
              ),
          if(widget.showPollIcon)    
            FooterIcon(
              icon: Icons.poll,
              onPressed: () {
                widget.onPollPress?.call();
                setLastPressedIcon(Icons.poll);
              },
              isDisabled: lastPressedIcon != null && lastPressedIcon != Icons.poll,
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
