import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'poll_option.dart';
import 'add_option_button.dart';
import 'showDaysBottomSheet.dart';

class Poll extends StatefulWidget {
  const Poll({Key? key}) : super(key: key);

  @override
  State<Poll> createState() => _PollState();
}

class _PollState extends State<Poll> {

  List<String> optionTexts = ['', '']; 
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ]; 
  int selectedDay = 1;

  void updateOption(int optionNumber, String value) {
    setState(() {
      optionTexts[optionNumber - 1] = value; 
    });
  }

  void removeOption(int index) {
    setState(() {
      optionTexts.removeAt(index);
      formKeys.removeAt(index);
    });
  }

  void updateSelectedDay(int selectedDay) {
  setState(() {
    this.selectedDay = selectedDay;
  });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
      borderRadius: BorderRadius.circular(15),  
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  'Poll ends in',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ),
              InkWell(
                onTap:  () => showDaysButtomSheet(context, selectedDay, updateSelectedDay),
                child: Row(
                  children: [
                    Text(
                      '$selectedDay days',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.cancel_rounded),
              ),  
            ],
          ),
          for (int i = 0; i < optionTexts.length; i++)
            PollOption(
              optionNumber: i + 1,
              formKey: formKeys[i],
              onChanged: (value) => updateOption(i + 1, value),
              onIconPress: () => removeOption(i),
            ),
          AddOptionButton(
            onPressed: () {
              setState(() {
                optionTexts.add(''); 
                formKeys.add(GlobalKey<FormState>()); 
              });
            },
          ),
        ],
      ),
    );
  }
}


 