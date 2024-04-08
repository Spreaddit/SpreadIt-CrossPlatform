import 'package:flutter/material.dart';

class CommunityAndRulesHeader extends StatefulWidget {

  final String communityIcon;
  final String communityName;

  const CommunityAndRulesHeader({
    required this.communityIcon,
    required this.communityName,
  });

  @override
  State<CommunityAndRulesHeader> createState() => _CommunityAndRulesHeaderState();
}

class _CommunityAndRulesHeaderState extends State<CommunityAndRulesHeader> {

  void navigateToRules() {
    Navigator.of(context).pushNamed('/rules');
  }

  void navigateToPostToCommunity() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: CircleAvatar(
            backgroundImage: AssetImage(widget.communityIcon),
            radius: 15,
          ),
        ),
        Text(
          widget.communityName,
          style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: navigateToPostToCommunity, 
          child: Container(
          padding: EdgeInsets.all(5), 
          child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: InkWell(
          onTap: navigateToRules,
          child: Text(
            'Rules',
             style: TextStyle(
              color: Colors.blue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
         ),
        ),
      ],
    );    
  }
}