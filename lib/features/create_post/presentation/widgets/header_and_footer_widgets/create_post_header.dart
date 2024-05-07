import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../../generic_widgets/small_custom_button.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';

/// [CreatePostHeader] : a template for a header which contains a header text and a button

class CreatePostHeader extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isEnabled;
  final VoidCallback onIconPress;
  final bool allowScheduling;
  final Function(BuildContext)? showSchedulePostBottomSheet;

  const CreatePostHeader({
    Key? key,
    this.showSchedulePostBottomSheet,
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
                  icon: Icon(Icons.more_horiz, size: 40),
                  onPressed: () {
                    widget.showSchedulePostBottomSheet!.call(context);
                  },
                ),
              ),
            SizedBox(width: 10),
            SmallButton(
              buttonText: widget.buttonText,
              onPressed: widget.onPressed,
              isEnabled: widget.isEnabled,
              width: 110,
              height: 20,
            ),
          ],
        ),
      ],
    );
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
