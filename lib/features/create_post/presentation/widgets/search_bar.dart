import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/discover_communities/data/community.dart';

class CommunitySearchBar extends StatefulWidget {
  final String hintText;
  final List<Community> searchList;
  final Function(List<Community>) onSearch;

  const CommunitySearchBar({
    required this.hintText,
    required this.searchList,
    required this.onSearch,
  });

  @override
  State<CommunitySearchBar> createState() => _CommunitySearchBarState();
}

class _CommunitySearchBarState extends State<CommunitySearchBar> {
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

  List<Community> _filterList(String query) {
    if (query.isEmpty) {
      return List.from(widget.searchList);
    } else {
      return widget.searchList
          .where(
            (e) => e.name.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
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
        backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 241, 243, 254)),
        trailing: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              searchController.clear();
            },
          ),
        ],
      ),
    );
  }
}
