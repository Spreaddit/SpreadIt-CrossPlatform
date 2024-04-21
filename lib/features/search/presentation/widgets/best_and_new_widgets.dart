import 'package:flutter/material.dart';

class BestAndNewWidget extends StatefulWidget {

  final IconData icon;
  final String bestOrNew;
  final String communityOrUserName;
  final VoidCallback onTap;

  const BestAndNewWidget({
    required this.icon,
    required this.bestOrNew,
    required this.communityOrUserName,
    required this.onTap,
  });

  @override
  State<BestAndNewWidget> createState() => _BestAndNewWidgetState();
}

class _BestAndNewWidgetState extends State<BestAndNewWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: widget.onTap,
        child: Row(
          children: [
            Icon(widget.icon),
            SizedBox(width: 8.0),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: widget.bestOrNew,
                  ),
                  TextSpan(
                    text: widget.communityOrUserName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}