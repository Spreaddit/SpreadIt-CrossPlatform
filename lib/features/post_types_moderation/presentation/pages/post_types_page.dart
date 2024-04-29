import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/switch_type_1.dart';
import 'package:spreadit_crossplatform/features/Account_Settings/presentation/widgets/switch_type_2.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/test_page.dart';

class PostTypes extends StatefulWidget {
  const PostTypes({Key? key}) : super(key: key);

  @override
  State<PostTypes> createState() => _PostTypesState();
}

class _PostTypesState extends State<PostTypes> {
  bool isImageLinksAllowed = false;
  bool isVideoLinksAllowed = false;
  bool isPollsAllowed = false;
  @override
  void initState() {
    //TODO GET ALLOWED POSTS
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Types'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(onPressed: (() {}), child: Text('Save')),
        ],
      ),
      body: Column(
        children: [
          SwitchBtn1(
            mainText: 'Image Links',
            onPressed: () {
              setState(() {
                isImageLinksAllowed = !isImageLinksAllowed;
                //TODO UPDATE BACk
              });
            },
            currentLightVal: isImageLinksAllowed,
            tertiaryText:
                "Allow images uploaded direcrtly to Spredit as well as links to popular image hosting sites such as Imgur",
          ),
          SwitchBtn1(
            mainText: 'Video Links',
            onPressed: () {
              setState(() {
                isVideoLinksAllowed = !isVideoLinksAllowed;
                //TODO UPDATE BACk
              });
            },
            currentLightVal: isVideoLinksAllowed,
            tertiaryText: "Allow videos uploaded directly to Spreadit",
          ),
          SwitchBtn1(
              mainText: 'Polls',
              onPressed: () {
                setState(() {
                  isPollsAllowed = !isPollsAllowed;
                  //TODO UPDATE BACk
                });
              },
              currentLightVal: isPollsAllowed,
              tertiaryText: "Allow polls in your community"),
        ],
      ),
    );
  }
}
