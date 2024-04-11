import 'package:flutter/material.dart';

class FooterIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const FooterIcon({
    required this.icon,
    required this.onPressed,
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
        icon: Icon(widget.icon, size: 25),
        onPressed: widget.onPressed,
      ),
    );
  }
}
