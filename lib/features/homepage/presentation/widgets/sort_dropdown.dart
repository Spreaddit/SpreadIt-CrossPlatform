import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';

class SortTypeMenu extends StatefulWidget {
  final void Function(PostCategories) onCategoryChanged;

  SortTypeMenu({required this.onCategoryChanged});

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
    return ElevatedButton(
      onPressed: showSortingMenu,
      child: ListTile(
        leading: Icon(icons[selectedCategory]),
        title: Text(PostCategories.values[selectedCategory].toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        trailing: Icon(
          Icons.arrow_downward_outlined,
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
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Sort By:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(icons[index % icons.length]),
                      title: Text(PostCategories.values[index].toString(),
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
