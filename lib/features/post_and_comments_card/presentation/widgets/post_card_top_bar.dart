import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/bottom_model_sheet.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/widgets/on_more_functios.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/share.dart';

class PostCardTopBar extends AppBar {
  PostCardTopBar(BuildContext context, String image)
      : super(
          toolbarHeight: 60,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.blue,
          title: Container(
              color: Colors.transparent,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Search onPressed logic here
                  },
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CustomBottomSheet(icons: [
                          Icons.notifications_on_rounded,
                          Icons.save,
                          Icons.copy,
                          Icons.flag,
                          Icons.block,
                          Icons.hide_source_rounded
                        ], text: [
                          "Subscribe to post",
                          "Save",
                          "Copy text",
                          "Report",
                          "Block account",
                          "Hide"
                        ], onPressedList: [
                          subscribeToPost,
                          save,
                          copyText,
                          report,
                          blockAccount,
                          hide
                        ]);
                      },
                    );
                  },
                  color: Colors.white,
                ),
                CircleAvatar(foregroundImage: NetworkImage(image)),
              ])),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.pop();
            },
            color: Colors.white,
          ),
        );
}
