import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_post_comments.dart';
import 'package:spreadit_crossplatform/features/user_profile/presentation/widgets/comments_shimmering.dart';
import '../../../generic_widgets/custom_bar.dart';
import '../../../homepage/presentation/widgets/post_feed.dart';
import '../../../user_profile/presentation/widgets/comments.dart';

/// A StatefulWidget representing the Saved page where users can view their saved posts and comments.
class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  int _selectedIndex = 0;
  List<Comment> commentsList = [];
  ScrollController _scrollController = ScrollController();
  bool isCommentsLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Fetches the user's saved comments.
  Future<void> fetchComments() async {
    try {
      var data = await fetchCommentsData('', 'saved', '1');
      setState(() {
        commentsList = data;
        isCommentsLoaded = true;
      });
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  /// Removes a comment from the list of saved comments.
  void removeCommentFromList(Comment comment) {
    setState(() {
      commentsList.remove(comment);
    });
  }

  /// Builds the selected page content based on the selected tab index.
  Widget _buildSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return SliverToBoxAdapter(
          child: PostFeed(
            scrollController: _scrollController,
            postCategory: PostCategories.save,
            isSavedPage: true,
          ),
        );
      case 1:
        return isCommentsLoaded
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final comment = commentsList[index];
                    return CommentWidget(
                      comment: comment,
                      saved: true,
                      onPressed: () => removeCommentFromList(comment),
                    );
                  },
                  childCount: commentsList.length,
                ),
              )
            : SliverList(
  delegate: SliverChildBuilderDelegate(
    (context, index) {
      return Container(
        color: Colors.white, // Set background color to white
        child: CommentShimmerWidget(saved: true),
      );
    },
    childCount: 10,
  ),
);

      default:
        return SliverToBoxAdapter(
          child: Text('Posts'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Saved'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color:  Colors.transparent,
        child: CustomScrollView(
          physics: ScrollPhysics(),
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: CustomBar(
                tabs: ['Posts', 'Comments'],
                onIndexChanged: _onIndexChanged,
              ),
            ),
            _buildSelectedPage(),
          ],
        ),
      ),
    );
  }
}
