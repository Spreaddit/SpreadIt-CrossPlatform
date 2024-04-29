import 'dart:math';

import 'package:flutter/material.dart';
import '../../../generic_widgets/communities_search_card.dart';

class SearchDisplayList extends StatefulWidget {

   final List displayList;
   final String type;

   const SearchDisplayList({
    required this.displayList,
    required this.type,
  });

  @override
  State<SearchDisplayList> createState() => _SearchDisplayListState();
}

class _SearchDisplayListState extends State<SearchDisplayList> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(top:3),
        shrinkWrap: true,
        itemCount: min(widget.displayList.length, 5),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {} , // navigate l 7etta 
            child: CommunitiesCard(
              communityName: widget.displayList[index]['name'],
              communityIcon: widget.displayList[index]['profilePic'],
              boxSize: 7,
              iconRadius: 13, 
              fontSize: 17,
              extraInfo: 
                widget.type == 'community' ? 
                  '${widget.displayList[index]['membersCount']} members' 
                   : '${widget.displayList[index]['karmaCount']} karma' ,
            ),
          );
        }
      ),     
    );
  }
}

// awaddih lel page bta3et el community aw el user da