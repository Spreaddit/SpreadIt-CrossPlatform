import 'package:flutter/material.dart';
import './join_button.dart';
import '../../../community/presentation/pages/community_page.dart';

/// `SubredditCard` is a StatelessWidget that represents a card for a subreddit.
///
/// It takes several parameters: `index`, `title`, `description`, `numberOfMembers`, and `image`. All of these parameters are required.
///
/// The `index` is used to identify the card, the `title` and `description` provide information about the subreddit, the `numberOfMembers` shows how many members the subreddit has, and the `image` is the image of the subreddit.
///
/// The `build` method is overridden to build the widget. It returns an `InkWell` widget, which makes its child widget tappable. When the `InkWell` is tapped, it navigates to the community page.
///
/// The child of the `InkWell` is a `Container` that has a margin and a border. The margin is symmetric, with vertical margins of 8.0 and horizontal margins of 16.0. The border is a simple border with a default color.
class SubredditCard extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final String numberOfMembers;
  final String image;

  const SubredditCard({
    Key? key,
    required this.index,
    required this.title,
    required this.description,
    required this.numberOfMembers,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CommunityPage(communityName: title),
          ),
        );
        // Navigate to the community page
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[350]!,
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        child: Card(
          elevation: 0.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '$index',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(image),
                            radius: 25.0,
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '$numberOfMembers members',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          JoinButton(
                            communityName: title,
                          )
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
