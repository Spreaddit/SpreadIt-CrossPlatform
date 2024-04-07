import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';

import '../../data/get_saved_posts.dart';

/// This widget is a post feed display,
/// which takes [PostCategories] as a constructor parameter
/// and creates a post feed, by fetching posts from
/// the respective endpoint
///
/// This example shows how a post feed of best posts can be created
///
/// ```dart
/// PostSaved(
///   postCategory: PostCategories.best,
/// ),
/// ```
class PostSaved extends StatefulWidget {
  final String username;
    PostSaved({
    required this.username,
  });
  @override
  _PostSavedState createState() => _PostSavedState();
}

class _PostSavedState extends State<PostSaved> {
  List<Post> items = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Post> fetchedItems = await getSavedPosts(widget.username,'saved');
    setState(() {
      if (fetchedItems.isEmpty) {
        CustomSnackbar(content: "an error occured. Please Refresh")
            .show(context);
      }
      items = fetchedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return PostWidget(
            post: items[index],
          );
        },
      ),
    );
  }
}
