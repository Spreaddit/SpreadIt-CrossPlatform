import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../generic_widgets/small_custom_button.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:intl/intl.dart';

/// [CreatePostHeader] : a template for a header which contains a header text and a button

class CreatePostHeader extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isEnabled;
  final VoidCallback onIconPress;
  final bool allowScheduling;

  const CreatePostHeader({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.isEnabled,
    required this.onIconPress,
    required this.allowScheduling,
  }) : super(key: key);

  @override
  State<CreatePostHeader> createState() => _CreatePostHeaderState();
}

class _CreatePostHeaderState extends State<CreatePostHeader> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isScheduled = false;

  ScheduleData getScheduleData() {
    return ScheduleData(
      isScheduled: isScheduled,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 40,
          width: 40,
          child: IconButton(
            icon: Icon(Icons.clear_rounded, size: 40),
            onPressed: widget.onIconPress,
          ),
        ),
        Row(
          children: [
            if (widget.allowScheduling == true)
              Container(
                height: 40,
                width: 40,
                child: IconButton(
                  icon: Icon(Icons.more_horiz,
                      size: 40), // Change this to the icon you want
                  onPressed: () {
                    showSchedulePostBottomSheet(context);
                  },
                ),
              ),
            SizedBox(width: 10),
            SmallButton(
              buttonText: widget.buttonText,
              onPressed: widget.onPressed,
              isEnabled: widget.isEnabled,
              width: 80,
              height: 20,
            ),
          ],
        ),
      ],
    );
  }

  void showSchedulePostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Post Settings',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Schedule Post'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showDateTimePickerModalSheet(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDateTimePickerModalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return IntrinsicHeight(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        title: Text('Schedule Post',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        trailing: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              isScheduled = false;
                              selectedDate = null;
                              selectedTime = null;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(0, 69, 172, 1.0),
                            foregroundColor: Colors.white,
                            side: BorderSide(
                                color: const Color.fromRGBO(0, 69, 172, 1.0),
                                width: 2),
                          ),
                          child: Text('Clear'),
                        ),
                      ),
                      ListTile(
                        title: Text('Starts on date'),
                        trailing: TextButton(
                          child: Text(
                            selectedDate != null
                                ? '${DateFormat.MMMd().format(selectedDate!)}, ${selectedDate!.year}'
                                : '${DateFormat.MMMd().format(DateTime.now())}, ${DateTime.now().year}',
                            style: TextStyle(
                                color: const Color.fromRGBO(0, 69, 172, 1.0)),
                          ),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                                isScheduled = true;
                              });
                            }
                          },
                        ),
                      ),
                      ListTile(
                        title: Text('Starts on time'),
                        trailing: TextButton(
                          child: Text(
                            selectedTime != null
                                ? selectedTime!.format(context)
                                : DateFormat.jm().format(DateTime.now()),
                            style: TextStyle(
                                color: const Color.fromRGBO(0, 69, 172, 1.0)),
                          ),
                          onPressed: () async {
                            selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.dialOnly,
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                      foregroundColor:
                                          const Color.fromRGBO(0, 69, 172, 1.0),
                                    )),
                                    canvasColor: Colors.red,
                                    primaryColor:
                                        Colors.white, // header background color
                                    colorScheme: ColorScheme.light(
                                      primary: Colors.grey, // dial hand color
                                      onPrimary:
                                          Colors.white, // dial hand dot color
                                      onSurface:
                                          Colors.black, // dial numbers color
                                      surface: Colors
                                          .white, // dial inner background color
                                    ),
                                    dialogBackgroundColor:
                                        Colors.white, // dialog background color
                                    timePickerTheme: TimePickerThemeData(
                                      dialHandColor: const Color.fromRGBO(
                                          0, 69, 172, 1.0), // dial hand color
                                      hourMinuteTextColor:
                                          Colors.black, // dial numbers color
                                      hourMinuteColor: Colors
                                          .white, // time background colour
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (selectedTime != null) {
                              setState(() {
                                isScheduled = true;
                              });
                            }
                            // Use selectedTime here
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

class ScheduleData {
  final bool isScheduled;
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;

  ScheduleData({
    required this.isScheduled,
    required this.selectedDate,
    required this.selectedTime,
  });
}
