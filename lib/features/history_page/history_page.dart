import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'History',
            style: TextStyle(
                fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Divider(
                height: 0.5,
              ),
            ),
            Container(
              color: Color.fromARGB(255, 225, 222, 218),
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Recent',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 39, 13, 1),
                    ),
                  ),
                ],
              ),
            ),
            PostFeed(
              postCategory: PostCategories.recent,
            ),
          ]),
        ),
      ),
    );
  }
}
