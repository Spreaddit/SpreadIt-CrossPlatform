import 'dart:async';

import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String hintText;
  final Function(String) updateSearchItem;
  final Function(String) navigateToSearchResult;
  final VoidCallback navigateToSuggestedResults;
  final String? initialBody;
  final String? communityOrUserName;
  final String? communityOrUserIcon;
  final bool? isContained;

  const CustomSearchBar({
    required this.formKey,
    required this.hintText,
    required this.updateSearchItem,
    required this.navigateToSearchResult,
    required this.navigateToSuggestedResults,
    this.initialBody,
    this.communityOrUserName,
    this.communityOrUserIcon,
    this.isContained,
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
      debounce(_controller.text, Duration(milliseconds: 500), (text) => widget.updateSearchItem(text));
    });
  }

  void debounce(String text, Duration duration, void Function(String) callback) {
    String? latestValue;
    Timer? timer;
    void handleUpdate() {
      if (latestValue != null) {
        callback(latestValue!);
        timer = null; 
      }
    }
    timer?.cancel();
    latestValue = text;
    timer = Timer(duration, handleUpdate);
  }

  final Map<Stream, Timer?> _timers = {};

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
          Form(
            key: widget.formKey,
            child: Row(
              children: [
                if (widget.isContained != null && widget.isContained == true && widget.communityOrUserName != null)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10), 
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.communityOrUserIcon!),
                          radius: 10,
                        ),
                        SizedBox(width:4),
                        Text(
                          widget.communityOrUserName!,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                Expanded(
                  child: FocusScope(
                    child: TextFormField(
                      onTap: widget.navigateToSuggestedResults,
                      onFieldSubmitted: (text) {
                        if (text.trim().isNotEmpty) {
                          widget.navigateToSearchResult(text);
                        } else {
                          FocusScope.of(context).unfocus();
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        hintText: widget.hintText,
                        prefixIcon: widget.communityOrUserIcon != null
                            ? null
                            : Icon(Icons.search), 
                      ),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


         
