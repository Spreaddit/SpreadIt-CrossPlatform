import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final Function(String) updateSearchItem;
  final String? communityOrUserName;
  final String? communityOrUserIcon;

  const CustomSearchBar({
    required this.hintText,
    required this.updateSearchItem,
    this.communityOrUserName,
    this.communityOrUserIcon,
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
    super.dispose();
  }

  void queryListener() {
    // call backend funcrion
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 330,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: SearchBar(
              hintText: widget.communityOrUserName != null && widget.communityOrUserIcon != null ? '' : widget.hintText,
              controller: searchController,
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 241, 243, 254)),
              leading: Icon(Icons.search),
              trailing: [
                IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
              ],
            ),
          ),
          if (widget.communityOrUserIcon != null && widget.communityOrUserName != null)
            Positioned(
              left: 50,
              child: Container(
                padding : EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:AssetImage(widget.communityOrUserIcon!),
                      radius:10,
                    ),  
                    SizedBox(width: 4),
                    Text(widget.communityOrUserName!),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
