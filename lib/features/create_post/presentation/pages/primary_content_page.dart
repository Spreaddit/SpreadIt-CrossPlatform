import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widgets/create_post_header.dart';
import '../widgets/title.dart';
import '../widgets/content.dart';
import '../widgets/create_post_footer.dart';
import '../widgets/create_post_secondary_footer.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
    bool isPrimaryFooterVisible = true;

  void toggleFooter() {
    setState(() {
      isPrimaryFooterVisible = !isPrimaryFooterVisible;
    });
  }

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
          isPrimaryFooterVisible? PostFooter(toggleFooter: toggleFooter) : SecondaryPostFooter(),
        ],)
    );
  }
}

/* TODOs 
1) law mafish title , deactivate el zorar
2) save the title wel content f 7etta 
3) a7ot actions lel footer
4) law 3andi link a7ottelo makano bardou
5) ab3at el haga di kollaha lel final content page 
6) navigations
7) unit testing 
 */