import 'package:flutter/material.dart';
import '../../../homepage/data/get_feed_posts.dart';
import '../../../homepage/presentation/widgets/post_feed.dart';
import '../../../generic_widgets/custom_bar.dart';
import '../widgets/comment_footer.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  int _selectedIndex = 0;
  bool _upvoted = true;
  bool _downvoted = true;
  int _number = 10;

  

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return SliverToBoxAdapter(
          child: PostFeed(
            postCategory: PostCategories.best,
          ),
        );
      case 1:
        return SliverToBoxAdapter(
          child: CommentFooter(
            onMorePressed: () {
              print('More button pressed');
            },
            onReplyPressed: () {
              print('Reply button pressed');
            },
            number: _number,
            upvoted: _upvoted,
            downvoted: _downvoted,
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
      body: CustomScrollView(
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
    );
  }
}
