import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';

class SortTypeMenu extends StatefulWidget {
  final void Function(PostCategories) onCategoryChanged;
  final int startSortIndex;
  final int endSortIndex;

  SortTypeMenu({
    required this.onCategoryChanged,
    required this.startSortIndex,
    required this.endSortIndex,
  });

  @override
  State<SortTypeMenu> createState() => _SortTypeMenuState();
}

class _SortTypeMenuState extends State<SortTypeMenu> {
  int selectedCategory = 0;
  List<IconData> icons = [
    Icons.grade_outlined,
    Icons.local_fire_department,
    Icons.new_label_outlined,
    Icons.trending_up_outlined,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: showSortingMenu,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.all(3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icons[selectedCategory],
                  color: Color.fromARGB(255, 70, 70, 70),
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  "${PostCategories.values[selectedCategory].toString().split('.').last.toUpperCase()} POSTS",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 70, 70, 70),
                  ),
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Color.fromARGB(255, 70, 70, 70),
            ),
          ],
        ),
      ),
    );
  }

  void showSortingMenu() async {
    await showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Sort By',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.endSortIndex + 1,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(icons[index % icons.length]),
                      title: Text(
                          PostCategories.values[index]
                              .toString()
                              .split('.')
                              .last,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      onTap: () {
                        _changeSortType(index);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeSortType(index) {
    setState(() {
      setState(() {
        selectedCategory = index;
        widget.onCategoryChanged(PostCategories.values[selectedCategory]);
      });
    });
  }
}
