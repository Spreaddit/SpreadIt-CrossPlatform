import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/primary_content_page.dart';
import 'package:spreadit_crossplatform/features/discover_communities/presentation/pages/discover_communities.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/home_page_drawer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/left_menu.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/top_bar.dart';

/// first page after login, displaying user feed
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  CurrentPage currentPage = CurrentPage.home;

  void changeSelectedIndex(int newIndex) {
    setState(() {
      selectedIndex = newIndex;
    });
    setState(() {});
    switch (selectedIndex) {
      case 0:
        Navigator.of(context).pushNamed(
          '/home',
          arguments: {'currentPage': CurrentPage.home},
        );
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/discover');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/primary-content-page');
        break;
      case 3:
        break;
      case 4:
        break;
    }
  }

  void onChangeHomeCategory(CurrentPage newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<PreferredSizeWidget?> appBars = [
      TopBar(
          currentPage: currentPage,
          context: context,
          onChangeHomeCategory: onChangeHomeCategory),
      //TODO: render popular
      AppBar(
        title: Text('Communties'),
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
    ];

    return Scaffold(
      appBar: appBars[selectedIndex],
      body: screens[selectedIndex],
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
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 255, 72, 0),
        onTap: (index) => changeSelectedIndex(index),
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
