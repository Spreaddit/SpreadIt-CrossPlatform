import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/primary_content_page.dart';
import 'package:spreadit_crossplatform/features/discover_communities/presentation/pages/discover_communities.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/home_page_drawer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/left_menu.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/top_bar.dart';

class HomePage extends StatefulWidget {
  final CurrentPage currentPage;
  HomePage({
    Key? key,
    this.currentPage = CurrentPage.home,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CurrentPage currentPage;

  @override
  void initState() {
    super.initState();
    setState(() {
      currentPage = widget.currentPage;
    });
  }

  void changeSelectedIndex(int newIndex) {
    setState(() {
      currentPage = CurrentPage.values[newIndex];
    });
    switch (currentPage) {
      case (CurrentPage.home):
        Navigator.of(context).pushNamed(
          '/home',
        );
        break;
      case CurrentPage.discover:
        Navigator.of(context).pushNamed(
          '/discover',
        );
        break;
      case CurrentPage.createPost:
        Navigator.of(context).pushNamed(
          '/primary-content-page',
        );
        break;
      case CurrentPage.chat:
        // Handle case when "Chat" icon is tapped
        break;
      case CurrentPage.inbox:
        // Handle case when "Inbox" icon is tapped
        break;
      case CurrentPage.popular:
        Navigator.of(context).pushNamed(
          '/popular',
        );
        break;
      case CurrentPage.all:
        Navigator.of(context).pushNamed(
          '/all',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<PreferredSizeWidget?> appBars = [
      TopBar(
        currentPage: widget.currentPage,
        context: context,
        onChangeHomeCategory: changeSelectedIndex,
      ),
      //TODO: render popular
      AppBar(
        title: Text('Communities'),
      ),
      null,
      AppBar(
        title: Text('Chat'),
      ),
      AppBar(
        title: Text('Inbox'),
      ),
    ];
    List<Widget> screens = [
      PostFeed(
        postCategory: PostCategories.best,
        showSortTypeChange: false,
      ),
      DiscoverCommunitiesBody(),
      CreatePost(),
      Text("chat"),
      Text("Inbox"),
      PostFeed(
        //TODO: implement trending searches in popular
        postCategory: PostCategories.hot,
        showSortTypeChange: false,
      ),
    ];

    return Scaffold(
      appBar: appBars[widget.currentPage.index % 5],
      body: screens[widget.currentPage.index],
      endDrawer: HomePageDrawer(),
      drawer: LeftMenu(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Inbox',
          ),
        ],
        currentIndex: widget.currentPage.index % 5,
        selectedItemColor: const Color.fromARGB(255, 255, 72, 0),
        onTap: (index) => changeSelectedIndex(index),
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
