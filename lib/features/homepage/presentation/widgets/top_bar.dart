import 'package:flutter/material.dart';

enum CurrentPage {
  home,
  discover,
  createPost,
  chat,
  inbox,
  popular,
  all,
}

class TopBar extends AppBar {
  final CurrentPage currentPage;
  final BuildContext context;
  final void Function(int)? onChangeHomeCategory;
  final Key? key;

  TopBar({
    this.currentPage = CurrentPage.home,
    required this.context,
    this.onChangeHomeCategory,
    this.key,
  }) : super(
          key: key,
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: currentPage.index != 0 && currentPage.index != 5
              ? Text(currentPage.toString().split('.').last)
              : chooseTitle(
                  currentPage,
                  onChangeHomeCategory,
                ),
          actions: [
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
                if (currentPage == CurrentPage.createPost) {
                  Navigator.of(context).pop();
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
              icon: Icon(
                currentPage == CurrentPage.createPost
                    ? Icons.arrow_back
                    : Icons.menu,
              ),
            ),
          ),
        );
}

Widget chooseTitle(
  CurrentPage currentPage,
  final void Function(int)? onChangeHomeCategory,
) {
  List<Widget> titles = [
    Container(
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
          onChangeHomeCategory!(newValue!.index);
        },
        items: CurrentPage.values
            .where((category) => category.index == 0 || category.index == 5)
            .map<DropdownMenuItem<CurrentPage>>(
              (newPage) => DropdownMenuItem<CurrentPage>(
                value: newPage,
                child: Text(newPage.toString().split('.').last),
              ),
            )
            .toList(),
      ),
    ),
  ];
  return titles[currentPage.index % 5];
}
