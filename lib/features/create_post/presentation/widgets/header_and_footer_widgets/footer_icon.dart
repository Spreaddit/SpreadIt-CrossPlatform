import 'package:flutter/material.dart';

/// [FooterIcon] : a template for how each icon is displayed

class FooterIcon extends StatefulWidget {

  final IconData icon;
  final VoidCallback? onPressed;
  final bool isDisabled;

  const FooterIcon({
    required this.icon,
    required this.onPressed,
    required this.isDisabled,
  });

  @override
  State<FooterIcon> createState() => _FooterIconState();
}

class _FooterIconState extends State<FooterIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
            height: 25,
            width: 25,
            margin: EdgeInsets.all(5),
            child: IconButton(
              icon: Icon(
                widget.icon,
                size: 25,
                color: widget.isDisabled? Colors.black54 : Colors.black,
                ),
              onPressed: (widget.onPressed != null && !widget.isDisabled) ? widget.onPressed! : null,
            ),
          );
  }
}