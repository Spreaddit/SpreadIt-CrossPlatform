import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// [CommunitiesCard] : a template of how the community data is displayed in [PostToCommunity] page

class CommunitiesCard extends StatefulWidget {

  final String communityName;
  final String communityIcon;
  final double boxSize;
  final double iconRadius;
  final double fontSize;

  const CommunitiesCard({
    required this.communityName,
    required this.communityIcon,
    required this.boxSize,
    required this.iconRadius,
    required this.fontSize,
  });

  @override
  State<CommunitiesCard> createState() => _CommunitiesCardState();
}

class _CommunitiesCardState extends State<CommunitiesCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin:EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.communityIcon),
              radius: widget.iconRadius,
            ),
            SizedBox(width: widget.boxSize),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(widget.communityName,
                  style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}