import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/secondary_footer_icon.dart';

class SecondaryPostFooter extends StatefulWidget {
  const SecondaryPostFooter({Key? key}) : super(key: key);

  @override
  State<SecondaryPostFooter> createState() => _SecondaryPostFooterState();
}

class _SecondaryPostFooterState extends State<SecondaryPostFooter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.only(bottom: 12),
      child: Column(
        children:[ 
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'What do you want to add?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              ),
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SecondaryFooterIcon(
              icon: Icons.attachment_rounded,
              text: 'Link',
              onPressed: () {},
              ),
            SecondaryFooterIcon(
              icon: Icons.photo,
              text: 'Image',
              onPressed: () {},
              ),
            SecondaryFooterIcon(
              icon: Icons.ondemand_video_rounded,
              text: 'Video',
              onPressed: () {},
              ),
            SecondaryFooterIcon(
              icon: Icons.poll,
              text: 'Poll',
              onPressed: () {},
              ), 
          ],
          ),
        ],
      ),
    );
  }
}

/* TODO
1) el action bta3 kol icon
2) el api bta3 el actions di */