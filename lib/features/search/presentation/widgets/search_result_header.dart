import 'package:flutter/material.dart';

/// this is the class of the search result header, 
/// Parametes :
/// 1) [labels] : a list of labels to be displayed 
/// 2) [onTabSelected] : a function which changes the page view displayed according to the selected tab

class SearchResultHeader extends StatefulWidget {
  final List labels;
  final ValueChanged<int> onTabSelected;

  SearchResultHeader({
    required this.labels, 
    required this.onTabSelected
    });

  @override
  _SearchResultHeaderState createState() => _SearchResultHeaderState();
}

class _SearchResultHeaderState extends State<SearchResultHeader> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.labels.length, (index) {
          return InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onTabSelected(_selectedIndex);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
                child: Stack(
                  children: [
                    Text(
                      widget.labels[index],
                      style: TextStyle(
                        color: _selectedIndex == index ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    if (_selectedIndex == index)
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 500),
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 2,
                          color: Colors.blue[900],
                        ),
                      ),
                    ],
                ),
            ),  
          );
        }),
      ),
    );
  }
}
