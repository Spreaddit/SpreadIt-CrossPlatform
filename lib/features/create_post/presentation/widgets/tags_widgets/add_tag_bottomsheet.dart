import 'package:flutter/material.dart';
import './tags.dart';

/// [showAddTagButtomSheet] : a bottom sheet which allows the user to add Spoiler or NSFW tags to his post

void showAddTagButtomSheet(
  BuildContext context,
  bool isSpoiler, 
  bool isNSFW, 
  bool isNSFWAllowed, 
  VoidCallback updateIsSpoiler,
  VoidCallback updateIsNSFW,
  ) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
        return  Container(
        margin: EdgeInsets.all(10),
        height: 200,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                'Add tags',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {Navigator.pop(context);},
                  icon: Icon(Icons.cancel_rounded),
                  iconSize: 40,
                  color: Colors.grey,
                  ),
                ],
              ),
            Tag(
              tagName: 'Spoiler',
              tagDescription: 'Tag posts that may ruin a surprise',
              tagIcon: Icon(Icons.new_releases_rounded),
              tagValue: isSpoiler,
              onChanged: (value) { 
                setState(() { 
                  isSpoiler = value;
                  });
                updateIsSpoiler ();  
                },
              ),
            isNSFWAllowed ? Tag(
              tagName: 'NSFW',
              tagDescription: 'Not safe for work',
              tagIcon: Icon(Icons.warning_rounded),
              tagValue: isNSFW,
              onChanged: (value) { 
                setState(() { 
                  isNSFW = value;
                  });
                updateIsNSFW ();  
                },
              ) : Spacer(),   
          ],
        ),
      );
        }
      );
    }
  );
} 
       