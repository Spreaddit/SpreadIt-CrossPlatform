import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String hintText;
  final Function(String) updateSearchItem;
  final Function(String) navigateToSearchResult;
  final String? initialBody;
  final String? communityOrUserName;
  final String? communityOrUserIcon;

  const CustomSearchBar({
    required this.formKey,
    required this.hintText,
    required this.updateSearchItem,
    required this.navigateToSearchResult,
    this.initialBody,
    this.communityOrUserName,
    this.communityOrUserIcon,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialBody);
    _controller.addListener(() {
      setState(() {
        widget.updateSearchItem(_controller.text);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: 330,
      decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: widget.formKey,
              child: TextFormField(
                onFieldSubmitted: widget.navigateToSearchResult,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed:()=> setState(()=> _controller.clear()),
                    icon: Icon(Icons.cancel),
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                controller: _controller,
              ),
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
