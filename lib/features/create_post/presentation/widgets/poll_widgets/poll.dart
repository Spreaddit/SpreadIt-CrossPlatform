import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'poll_option.dart';
import 'add_option_button.dart';
import 'showDaysBottomSheet.dart';

/// [Poll] : renders the poll creation form

class Poll extends StatefulWidget {

  final VoidCallback? onPollCancel;
  final Function(IconData?) setLastPressedIcon;
  final List<GlobalKey<FormState>> formkeys;
  final List<String> pollOptions;
  final int selectedDay;
  final void Function(int, String) updatePollOption;
  final void Function(int) removePollOption;
  final void Function(int) updateSelectedDay;
  final List<String> initialBody;

  const Poll({
    required this.onPollCancel,
    required this.setLastPressedIcon,
    required this.formkeys,
    required this.pollOptions,
    required this.selectedDay,
    required this.updatePollOption,
    required this.removePollOption,
    required this.updateSelectedDay,
    required this.initialBody,
  });

  @override
  State<Poll> createState() => _PollState();
}

class _PollState extends State<Poll> {

  void cancelPoll() {
    widget.onPollCancel?.call();
    widget.setLastPressedIcon(null);
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
                onTap:  () => showDaysButtomSheet(context, widget.selectedDay, widget.updateSelectedDay),
                child: Row(
                  children: [
                    Text(
                      '${widget.selectedDay} days',
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
                onPressed: cancelPoll,
                icon: Icon(Icons.cancel_rounded),
              ),  
            ],
          ),
          for (int i = 0; i < widget.pollOptions.length; i++)
            PollOption(
              optionNumber: i + 1,
              formKey: widget.formkeys[i],
              onChanged: (value) => widget.updatePollOption(i + 1, value),
              onIconPress: () => widget.removePollOption(i),
              initialBody: widget.initialBody[i],
            ),
          AddOptionButton(
            onPressed: () {
              setState(() {
                widget.pollOptions.add(''); 
                GlobalKey<FormState> newFormKey = GlobalKey<FormState>();
                widget.formkeys.add(newFormKey); 
                widget.initialBody.add('');
              });
            },
          ),
        ],
      ),
    );
  }
}


 