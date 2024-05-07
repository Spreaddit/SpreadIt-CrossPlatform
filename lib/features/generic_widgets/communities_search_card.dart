import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// [CommunitiesCard] : a template of how the community data is displayed in [PostToCommunity] page

class CommunitiesCard extends StatefulWidget {

  final String communityName;
  final String communityIcon;
  final double boxSize;
  final double iconRadius;
  final double fontSize;
  final String? extraInfo;

  const CommunitiesCard({
    required this.communityName,
    required this.communityIcon,
    required this.boxSize,
    required this.iconRadius,
    required this.fontSize,
    this.extraInfo,
  });

  @override
  State<CommunitiesCard> createState() => _CommunitiesCardState();
}

class _CommunitiesCardState extends State<CommunitiesCard> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin:EdgeInsets.all(15),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.communityIcon),
            radius: widget.iconRadius,
          ),
          SizedBox(width: widget.boxSize),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.communityName,
                style: TextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.extraInfo != null)
                Text(
                  widget.extraInfo!,
                  style: TextStyle(
                  fontSize: (widget.fontSize) - 4,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}