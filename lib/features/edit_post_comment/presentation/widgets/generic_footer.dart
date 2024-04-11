import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/footer_icon.dart';

class GenericFooter extends StatefulWidget {
  final VoidCallback? toggleFooter;
  final bool showAttachmentIon;
  final bool showPhotoIcon;
  final bool showVideoIcon;
  final bool showPollIcon;

  const GenericFooter(
      {required this.toggleFooter,
      required this.showAttachmentIon,
      required this.showPhotoIcon,
      required this.showVideoIcon,
      required this.showPollIcon});

  @override
  State<GenericFooter> createState() => _GenericFooterState();
}

class _GenericFooterState extends State<GenericFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          FooterIcon(icon: Icons.attachment_rounded, onPressed: () {}),
          if (widget.showPhotoIcon)
            FooterIcon(icon: Icons.photo, onPressed: () {}),
          if (widget.showVideoIcon)
            FooterIcon(icon: Icons.ondemand_video_rounded, onPressed: () {}),
          if (widget.showPollIcon)
            FooterIcon(icon: Icons.poll, onPressed: () {}),
          if (widget.toggleFooter != null)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 15),
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
