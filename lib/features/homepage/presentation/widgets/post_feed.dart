import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';

class PostFeed extends StatefulWidget {
  PostCategories postCategory;
  PostFeed({
    required this.postCategory,
  });

  @override
  _PostFeedState createState() => _PostFeedState();
}

class _PostFeedState extends State<PostFeed> {
  List<Post> items = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Post> fetchedItems = await getFeedPosts(widget.postCategory);
    setState(() {
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
