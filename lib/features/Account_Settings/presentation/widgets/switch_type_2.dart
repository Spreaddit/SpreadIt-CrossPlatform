import 'package:flutter/material.dart';

/// A customizable switch button widget with two different icons representing on and off states.
class SwitchBtn2 extends StatefulWidget {
  /// Creates a switch button widget.
  ///
  /// Parameters:
  /// - [filledIconData] : [IconData] The icon to be displayed when the switch is on [required].
  /// - [outlinedIconData] : [IconData] The icon to be displayed when the switch is off [required].
  /// - [mainText] : [String] The main text of the switch button [required].
  /// - [onPressed] : [Function] The function called when the switch button is pressed [required].
  /// - [currentLightVal] : [bool] The current value of the switch [required].
  /// - [switchActiveClr] : [Color] The color of the switch when active (default is [Color.fromARGB(255, 7, 116, 205)]).
  /// - [thumbActiveClr] : [Color] The color of the switch thumb when active (default is [Colors.white]).
  const SwitchBtn2({
    Key? key,
    required this.filledIconData,
    required this.outlinedIconData,
    required this.mainText,
    required this.currentLightVal,
    required this.onPressed,
    this.switchActiveClr = const Color.fromARGB(255, 7, 116, 205),
    this.thumbActiveClr = Colors.white,
  }) : super(key: key);

  final IconData filledIconData;
  final IconData outlinedIconData;
  final Function onPressed;
  final bool currentLightVal;
  final Color switchActiveClr;
  final Color thumbActiveClr;
  final String mainText;

  @override
  State<SwitchBtn2> createState() => SwitchBtn2State();
}

/// [SwitchBtn2] state.
class SwitchBtn2State extends State<SwitchBtn2> {
  /// Current value of the switch.
  late bool lightVal = widget.currentLightVal;
  /// Current icon.
  late IconData iconData;

  /// Gets the current value of the switch.
  bool getCurrentState() {
    return lightVal;
  }

  /// Changes the state of the switch and runs the function [widget.onPressed].
  void changeState() {
    setState(() {
      widget.onPressed();
      iconData = (lightVal) ? widget.filledIconData : widget.outlinedIconData;
    });
    print(lightVal);
  }

  @override
  Widget build(BuildContext context) {
    lightVal = widget.currentLightVal;
    iconData = (lightVal) ? widget.filledIconData : widget.outlinedIconData;
    return TextButton(
      onPressed: (() {
        changeState();
      }),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
        overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Colors.black,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: widget.mainText,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.25),
                    ),
                  ]),
                  softWrap: true,
                ),
              ),
              Transform.scale(
                scale: 0.75,
                child: Switch(
                  value: lightVal,
                  activeColor: widget.switchActiveClr,
                  activeTrackColor: widget.switchActiveClr,
                  thumbColor:
                      MaterialStatePropertyAll<Color>(widget.thumbActiveClr),
                  onChanged: (bool val) {
                    changeState();
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
