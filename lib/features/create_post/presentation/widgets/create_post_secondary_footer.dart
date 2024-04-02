import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            Column(
              children: [
                CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 206, 206, 206),
                radius: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.attachment_rounded,
                    size: 20,
                    color: Colors.black,
                    ),
                  onPressed: () {},
                ),
              ),
              Text('Link'),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 206, 206, 206),
                radius: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.photo,
                    size: 20,
                    color: Colors.black,
                    ),
                  onPressed: () {},
                ),
              ),
              Text('Image'),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 206, 206, 206),
                radius: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.ondemand_video_rounded,
                    size: 20,
                    color: Colors.black,
                    ),
                  onPressed: () {},
                ),
              ),
              Text('Video'),
              ],
            ),
            Column(
              children: [
                CircleAvatar(
                backgroundColor: Color.fromARGB(255, 206, 206, 206),
                radius: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.poll,
                    size: 20,
                    color: Colors.black,
                    ),
                  onPressed: () {},
                ),
              ),
              Text('Poll'),
              ],
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