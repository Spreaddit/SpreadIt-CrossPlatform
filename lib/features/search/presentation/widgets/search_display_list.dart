import 'package:flutter/material.dart';
import '../../../generic_widgets/communities_search_card.dart';

class SearchDisplayList extends StatefulWidget {

   final List displayList;
  const SearchDisplayList({
    required this.displayList,
  });

  @override
  State<SearchDisplayList> createState() => _SearchDisplayListState();
}

class _SearchDisplayListState extends State<SearchDisplayList> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child:Expanded(
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {} , // navigate l 7etta 
              child: CommunitiesCard(
                communityName: widget.displayList[index]['name'],
                communityIcon: widget.displayList[index]['profilePic'],
                boxSize: 5,
                iconRadius: 10, 
                fontSize: 10,
              ),
            );
          }
        ),
      ),      
    );
  }
}

// awaddih lel page bta3et el community aw el user da