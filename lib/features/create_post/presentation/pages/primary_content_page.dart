import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/create_post_header.dart';
import '../widgets/title.dart';
import '../widgets/content.dart';
import '../widgets/create_post_footer.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  void navigateToPostToCommunity() {
    Navigator.of(context).pushNamed('/post-to-community');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: CreatePostHeader(
              buttonText: "Next",
              onPressed: navigateToPostToCommunity,
              ),
          ),
          PostTitle(),
          PostContent(),
          PostFooter(),
        ],)
    );
  }
}

/* TODOs 
1) azabbat el navigation
2) azabbat el footer 
3) a7ot actions lel footer
 */