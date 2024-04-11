import 'package:flutter/material.dart';

enum CurrentPage {
  home,
  popular,
  community,
  all,
}

class TopBar extends AppBar {
  final CurrentPage currentPage;
  final BuildContext context;

  TopBar({
    this.currentPage = CurrentPage.home,
    required this.context,
  }) : super(
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: currentPage == CurrentPage.home ||
                  currentPage == CurrentPage.popular
              ? Container(
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(18, 0, 0, 0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: DropdownButton<CurrentPage>(
                    value: currentPage,
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    onChanged: (newValue) {
                      Navigator.of(context)
                          .pushNamed('/${newValue.toString().split('.').last}');
                    },
                    items: CurrentPage.values
                        .where((category) =>
                            category.index == 0 || category.index == 1)
                        .map<DropdownMenuItem<CurrentPage>>(
                          (newPage) => DropdownMenuItem<CurrentPage>(
                            value: newPage,
                            child: Text(newPage.toString().split('.').last),
                          ),
                        )
                        .toList(),
                  ),
                )
              : Center(
                  child: Text(
                    currentPage.toString().split('.').last,
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                if (currentPage != CurrentPage.home &&
                    currentPage != CurrentPage.popular) {
                  Navigator.of(context).pushNamed('/home');
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
              icon: Icon(
                currentPage == CurrentPage.home ||
                        currentPage == CurrentPage.popular
                    ? Icons.menu
                    : Icons.arrow_back,
              ),
            ),
          ),
        );
}
