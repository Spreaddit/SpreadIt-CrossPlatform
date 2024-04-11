import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/delete_post.dart';
import '../../../generic_widgets/small_custom_button.dart';

void deletePostButtomSheet( BuildContext context, int postID) {

  void handleDeletePost (int postId) async {
    int response = await deletePost(postId);
    if (response == 200) {
      CustomSnackbar(content: 'Your post is deleted successfully').show(context);
      Navigator.pop(context);
      Navigator.pop(context);
    }
    else if (response == 500) {
      CustomSnackbar(content:'Internal server error, try again later').show(context);
    }
    else {
      CustomSnackbar(content: 'Post not found').show(context);
    }
  }

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        margin: EdgeInsets.all(15),
        height: 150,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                'Delete post?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Once you delete this post, it can't be restored. ",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallButton(
                    buttonText: 'Go Back',
                    onPressed: () {Navigator.pop(context);},
                    isEnabled: true,
                    width: 160,
                    height: 30,
                    backgroundColor: Color.fromARGB(255, 214, 214, 214),
                    foregroundColor: const Color.fromARGB(255, 138, 138, 138),
                  ),
                  SmallButton(
                    buttonText: 'Delete',
                    onPressed: () {handleDeletePost(postID);},
                    isEnabled: true,
                    width: 160,
                    height: 30,
                  ),  
                ],
              ),
            ],
          ),
        ),
      );
    }
  );
}



