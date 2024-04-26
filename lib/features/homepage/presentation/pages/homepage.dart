import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/pages/chat_user_page.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/primary_content_page.dart';
import 'package:spreadit_crossplatform/features/discover_communities/presentation/pages/discover_communities.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/home_page_drawer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/left_menu.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/top_bar.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/pages/notification_page.dart';

CurrentPage previousPage = CurrentPage.home;

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
  late GlobalKey<_HomePageState> _homePageKey;
  int chatFilterSelectedOption = 3;

  @override
  void initState() {
    super.initState();
    _homePageKey = GlobalKey<_HomePageState>();
    setState(() {
      currentPage = widget.currentPage;
    });
  }

  void changeSelectedIndex(int newIndex) {
    if (newIndex == 2) {
      Navigator.of(context).pushNamed('/primary-content-page');
      return;
    }
    if (currentPage.index == newIndex) return;
    setState(() {
      currentPage = CurrentPage.values[newIndex];
    });
    if (currentPage.index <= 5) {
      previousPage = currentPage;
    }
  }

  void onChangeChatFilter(int chatFilterSelectedOption) {
    setState(() {
      this.chatFilterSelectedOption = chatFilterSelectedOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      PostFeed(
        postCategory: PostCategories.best,
        showSortTypeChange: false,
      ),
      DiscoverCommunitiesBody(),
      CreatePost(),
      ChatUserPage(
        selectedOption: chatFilterSelectedOption,
      ),
      NotificationPage(),
      PostFeed(
        postCategory: PostCategories.hot,
        showSortTypeChange: false,
      ),
      PostFeed(
        postCategory: PostCategories.best,
        showSortTypeChange: true,
      ),
    ];

    Widget bottomNavigationBar = BottomNavigationBar(
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
      currentIndex:
          currentPage.index <= 5 ? currentPage.index % 5 : previousPage.index,
      selectedItemColor: const Color.fromARGB(255, 255, 72, 0),
      onTap: (index) => changeSelectedIndex(index),
      unselectedItemColor: Colors.black,
    );

    return Scaffold(
      appBar: TopBar(
          key: _homePageKey,
          context: context,
          currentPage: currentPage,
          onChangeHomeCategory: changeSelectedIndex,
          onChangeChatFilter: onChangeChatFilter,
          chatFilterSelectedOption: chatFilterSelectedOption),
      body: screens[currentPage.index],
      endDrawer: HomePageDrawer(),
      drawer: LeftMenu(),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton:
          currentPage == CurrentPage.chat ? floatingNewChatButton() : null,
    );
  }
}
