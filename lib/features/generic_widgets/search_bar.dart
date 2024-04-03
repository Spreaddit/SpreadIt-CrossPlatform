import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {

  final String hintText;
  final List<Map<String, dynamic>> searchList;
  final Function(List<Map<String, dynamic>>) onSearch;

  const CustomSearchBar({
    required this.hintText,
    required this.searchList,
    required this.onSearch,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {

  final TextEditingController searchController = TextEditingController();

  @override 
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
  }

  @override 
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    super.dispose;
  }

  void queryListener() {
    widget.onSearch(_filterList(searchController.text));
  }

  List<Map<String, dynamic>> _filterList(String query) {
    if (query.isEmpty) {
      return List.from(widget.searchList);
    } 
    else {
      return widget.searchList
          .where((e) =>
              e['communityName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: SearchBar(
          hintText: 'Search for a community',
          controller: searchController,
          backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 241, 243, 254)),
          trailing: [
            IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {searchController.clear();},
            ),
          ],
        ),
    );
  }
}