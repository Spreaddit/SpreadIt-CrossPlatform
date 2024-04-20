import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RecentSearches extends StatefulWidget {
  const RecentSearches({Key? key}) : super(key: key);

  @override
  State<RecentSearches> createState() => _RecentSearchesState();
}

class _RecentSearchesState extends State<RecentSearches> {

  List recents = [' cyberTruck', 'Taylor Swift', 'Taslimet el software etbakkaret', ' ana t3ebt', 'yarab nekhlas'];

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin : EdgeInsets.fromLTRB(10, 0, 10, 2),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Icon(Icons.browse_gallery_outlined),
                        ),
                        Text(
                          recents[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                  ),
                ],
              );
            },
                ),
        ),
    );
  }
}

/*TO DOS
1) lamma el user yekhtar haga aw y-search 3ala haga , el haga di tetne2el fo2 (the list only displays 3 results) */