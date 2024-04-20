import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSearchBar extends StatefulWidget {

  final String hintText;
  final List searchList;
  final Function(String) updateSearchItem;
  final Function(List) onSearch;
  final String? initialText;

  const CustomSearchBar({
    required this.hintText,
    required this.searchList,
    required this.updateSearchItem,
    required this.onSearch,
    this.initialText,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {

  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(queryListener);
  }

  @override
  void dispose() {
    controller.removeListener(queryListener);
    controller.dispose();
    super.dispose;
  }

  void queryListener() {
    widget.onSearch(filterList(controller.text));
    widget.updateSearchItem(controller.text);
  }

  List filterList(String query) {
    if (query.isNotEmpty) {
      return widget.searchList
          .where(
            (e) => e.name.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }
    else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      width: 330,
      height: 40,   
      child: SearchBar(
        //controller: controller,
        hintText: widget.initialText != null ? widget.initialText : widget.hintText,
        leading: Icon(Icons.search),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) => Colors.grey[200]),
        trailing:  controller.text.isNotEmpty ?
        [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
            },
          ),
        ] : 
        [],
      ),
    );
  }
}