import 'package:flutter/material.dart';

/// A custom buttom sheet that appears when the user presses a filter button (Time or Sort).
/// Parameters:
/// 1) [title] : the title of this bottomsheet
/// 2) [items] : a list of the items to be displayed.
/// 3) [updateFilter] : a function to call th ecorresponding filtering api upon filter selection
/// 4) [context]  

void openBottomSheet (
  String title,
  List items,
  Function(int) updateFilter,
  BuildContext context,
)
{
  int? selectedIndex ;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
        return Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () { Navigator.pop(context);},
                    icon: Icon(Icons.cancel),
                    iconSize: 30,
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      title: SizedBox(
                        width: MediaQuery.of(context).size.width - 150,
                        child: Text(
                          items[index],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      value: index,
                      groupValue: selectedIndex,
                      onChanged: (int? value) {
                        setState(() {
                          selectedIndex = value!;
                        });
                        updateFilter(selectedIndex!);
                      }
                    );
                  }, 
                ),
              ),
            ],
          ), 
        );
        }
      );
    },
  );
}