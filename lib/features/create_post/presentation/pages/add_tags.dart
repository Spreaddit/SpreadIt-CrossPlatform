import'package:flutter/material.dart';
import '../widgets/tags.dart';

class Tags extends StatefulWidget {
  const Tags({Key? key}) : super(key: key);

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {

  bool isNSFWAllowed = true;
  bool isSpoiler = false;
  bool isNSFW = false;


  void navigateToFinalContentPage() {
    Navigator.of(context).pushNamed('/final-content-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Add tags',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                ),
                IconButton(
                  onPressed: navigateToFinalContentPage,
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
                },
              ) : Spacer(),  
          ],),
      )
    );
  }
}

/* TODOs 
1) ab3at el is hagat di l barra
2) akhod ml api howwa aslan masmou7 NSFW walla laa
3) navigations
4) unit testing */