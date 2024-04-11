import 'package:flutter/material.dart';

class SecondaryFooterIcon extends StatefulWidget {

  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final bool isDisabled;

  const SecondaryFooterIcon({
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.isDisabled,
  });

  @override
  State<SecondaryFooterIcon> createState() => _SecondaryFooterIconState();
}

class _SecondaryFooterIconState extends State<SecondaryFooterIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                CircleAvatar(
                backgroundColor: widget.isDisabled? const Color.fromARGB(255, 206, 206, 206) : Colors.blue,
                radius: 20,
                child: IconButton(
                  icon: Icon(
                    widget.icon,
                    size: 20,
                    color: (widget.isDisabled || widget.isDisabled == null) ? Colors.black : Colors.white,
                    ),
                  onPressed: widget.isDisabled? null : widget.onPressed,
                ),
              ),
              Text(widget.text),
              ],
            );
  }
}