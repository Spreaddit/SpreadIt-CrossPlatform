import 'dart:async';

import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/search/data/post_search_log.dart';

/// A custom search bar in which the user Writes his search query.
/// Parameters :
/// 1) [formKey] : the formkey of the text field.
/// 2) [hintText] : the text which will be displayed on the search bar when it is empty.
/// 3) [updateSearchItem] : a function which updates the variable for the search item.
/// 4) [navigateToSearchResult] : on form submission, navigate to the search result of the search item.
/// 5) [navigateToSuggestedResults] : on focused, suggested search results are displayed.
/// 6) [initialBody] : if the search bar was passed to another page, the search query is also passed.
/// 7) [communityOrUserName] : an optional parameter to display the community or user name in case the user searches from inside a community page or user profile.
/// 8) [communityOrUserIcon] : an optional parameter to display the community or user icon in case the user searches from inside a community page or user profile.
/// 9) [isContained] : a boolean to determinate if the communtiy or username are passed or not , and if they are, they will be wrapped in a container.
/// 10) [inCommunityPage] : a boolean to determine if the user enters the seach from a community page.
/// 11) [inUserProfile] :  a boolean to determine if the user enters the seach from a user profile.

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
  final bool? inCommunityPage;
  final bool? inUserProfile;

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
    this.inCommunityPage,
    this.inUserProfile,
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
      widget.updateSearchItem(_controller.text); 
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void saveSearchLog (String query) async {
    if (widget.inCommunityPage != null && widget.inCommunityPage == true) {
      await PostSearchLog().postSearchLog(query,'community', widget.communityOrUserName!, null,false);
    }
    else if (widget.inUserProfile != null && widget.inUserProfile == true) {
      await PostSearchLog().postSearchLog(query,'user', null, widget.communityOrUserName!,true);
      print('user query log submitted');
    }
    else {
      await PostSearchLog().postSearchLog(query,'normal', null, null , false);
    }

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
                          saveSearchLog(text);
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


         
