import 'package:flutter/material.dart';

/// A custom class for diasplaying the 'best of' and 'New in' text s in the in community or user search.
/// Parameters:
/// 1) [icon] : the icon to be displyed to the left 
/// 2) [bestOrNew] : 'Best of' or 'New in' text
/// 3) [communityOrUserName] : the community or user name to be displayed next to bestOrNew text
/// 4) [onTap] : the function which navigates the user to the search results with the corresponding filter on text tap
/// 
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