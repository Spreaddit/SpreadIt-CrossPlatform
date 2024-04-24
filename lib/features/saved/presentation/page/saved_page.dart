import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/get_post_comments.dart';
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
  String username =
      ' '; // Dummy data, not actually used when fetching the function;

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
      var data = await fetchCommentsData(username, 'saved', '1');
      setState(() {
        commentsList = data;
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
            postCategory: PostCategories.save,
            isSavedPage: true,
          ),
        );
      case 1:
        return SliverList(
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
        color: _selectedIndex == 1 ? Colors.grey[200] : Colors.transparent,
        child: CustomScrollView(
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
