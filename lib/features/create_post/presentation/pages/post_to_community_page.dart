import 'package:flutter/material.dart';
import '../../../generic_widgets/search_bar.dart';
import '../widgets/buttonless_header.dart';

class PostToCommunity extends StatefulWidget { 
  const PostToCommunity({Key? key}) : super(key: key);

  @override
  State<PostToCommunity> createState() => _PostToCommunityState();
}

class _PostToCommunityState extends State<PostToCommunity> {

  List<dynamic> communities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        ButtonlesHeader(text: "Post to"),
        CustomSearchBar(hintText: 'Search for a community'),
        Container(
          width:370,
          height:50,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side:BorderSide(
                color: Colors.blue,
              )
            ),
            child: Text(
              "See more",
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ),
        ),
          ],
      ),
    );
  }
}

/*
TODOs:
1) kol community agebha ml get api a3mellah map fl list 
2) agahhez el api call elli ha-get biha el communities 
3) action l see more button 
4) lamma adous 3ala community y-render el page bta3et el content w ma7tout fiha el community fo2
 */