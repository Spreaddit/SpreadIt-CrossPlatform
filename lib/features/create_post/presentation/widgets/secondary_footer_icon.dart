import 'package:flutter/material.dart';

class SecondaryFooterIcon extends StatefulWidget {

  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const SecondaryFooterIcon({
    required this.icon,
    required this.text,
    required this.onPressed,
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
                backgroundColor: const Color.fromARGB(255, 206, 206, 206),
                radius: 20,
                child: IconButton(
                  icon: Icon(
                    widget.icon,
                    size: 20,
                    color: Colors.black,
                    ),
                  onPressed: widget.onPressed,
                ),
              ),
              Text(widget.text),
              ],
            );
  }
}