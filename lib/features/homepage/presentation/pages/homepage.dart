import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/pages/chat_user_page.dart';
import 'package:spreadit_crossplatform/features/chat/presentation/widgets/floating_new_chat_button.dart';
import 'package:spreadit_crossplatform/features/create_post/presentation/pages/primary_content_page.dart';
import 'package:spreadit_crossplatform/features/discover_communities/presentation/pages/discover_communities.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/home_page_drawer.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/left_menu.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/top_bar.dart';
import 'package:spreadit_crossplatform/features/messages/presentation/pages/message_inbox.dart';
import 'package:spreadit_crossplatform/features/notifications/Presentation/pages/notification_page.dart';

CurrentPage previousPage = CurrentPage.home;

class HomePage extends StatefulWidget {
  final CurrentPage currentPage;
  final CurrentPage currentSubPage;

  HomePage({
    Key? key,
    this.currentPage = CurrentPage.home,
    this.currentSubPage = CurrentPage.notifications,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CurrentPage currentPage;
  late CurrentPage currentSubPage;
  late GlobalKey<_HomePageState> _homePageKey;
  int chatFilterSelectedOption = 3;

  @override
  void initState() {
    super.initState();
    _homePageKey = GlobalKey<_HomePageState>();
    setState(() {
      currentPage = widget.currentPage;
      currentSubPage = widget.currentSubPage;
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
      SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: ToggleButtons(
                  constraints: BoxConstraints.expand(
                      width: MediaQuery.of(context).size.width / 2),
                  borderRadius: BorderRadius.zero,
                  borderWidth: 0,
                  selectedBorderColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  borderColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: (index) {
                    setState(() {
                      currentSubPage = index == 0
                          ? CurrentPage.notifications
                          : CurrentPage.messages;
                    });
                  },
                  isSelected: [
                    currentSubPage == CurrentPage.notifications,
                    currentSubPage == CurrentPage.messages,
                  ],
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: currentSubPage == CurrentPage.notifications
                                ? Color.fromRGBO(0, 69, 172, 1.0)
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications),
                          SizedBox(width: 10),
                          Text("Notifications"),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: currentSubPage == CurrentPage.messages
                                ? Color.fromRGBO(0, 69, 172, 1.0)
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.message),
                          SizedBox(width: 10),
                          Text("Messages"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              currentSubPage == CurrentPage.notifications
                  ? NotificationPage()
                  : MessageInbox(),
            ],
          ),
        ),
      ),
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
      floatingActionButton: currentPage == CurrentPage.chat
          ? floatingNewChatButton(context)
          : null,
    );
  }
}
