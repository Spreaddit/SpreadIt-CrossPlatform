import 'package:flutter/material.dart';
import '../../../../generic_widgets/small_custom_button.dart';


void showDaysButtomSheet(BuildContext context, int day, Function(int) onDaySelected) {

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
           return Container(
            margin: EdgeInsets.all(15),
            height: 1100,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: List.generate(
                    7,
                    (index) {
                      int i = 7 - index;
                      return RadioListTile<int>(
                        title: Text('$i days'),
                        value: i,
                        groupValue: day,
                        onChanged: (int? value) {
                          setState(() {
                              day = value!;
                            });
                          onDaySelected(day);
                          },
                        );
                      },
                    ),
                  ),
                ),
              SmallButton(
                buttonText: 'Close',
                onPressed: () {Navigator.pop(context);},
                isEnabled: true,
                width: 300, 
                height: 40,
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

