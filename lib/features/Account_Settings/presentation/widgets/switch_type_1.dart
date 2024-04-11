import 'package:flutter/material.dart';

/// A customizable switch button widget with an icon, main text, and switch.
class SwitchBtn1 extends StatefulWidget {
  /// Creates a switch button widget.
  ///
  /// Parameters:
  /// - [iconData] : [IconData] The icon to be displayed [required].
  /// - [mainText] : [String] The main text of the switch button [required].
  /// - [onPressed] : [Function] The function called when the switch button is pressed [required].
  /// - [currentLightVal] : [bool] The current value of the switch [required].
  /// - [switchActiveClr] : [Color] The color of the switch when active (default is [Color.fromARGB(255, 7, 116, 205)]).
  /// - [thumbActiveClr] : [Color] The color of the switch thumb when active (default is [Colors.white]).
  /// - [tertiaryText] : [String] The additional text to be displayed below the main text (default is an empty string).
  const SwitchBtn1(
      {Key? key,
      required this.iconData,
      required this.mainText,
      required this.onPressed,
      required this.currentLightVal,
      this.switchActiveClr = const Color.fromARGB(255, 7, 116, 205),
      this.thumbActiveClr = Colors.white,
      this.tertiaryText = ""})
      : super(key: key);

  final IconData iconData;
  final Function onPressed;
  final Color switchActiveClr;
  final bool currentLightVal;
  final Color thumbActiveClr;
  final String mainText;
  final String tertiaryText;

  @override
  State<SwitchBtn1> createState() => SwitchBtn1State();
}

/// [SwitchBtn1] state.
class SwitchBtn1State extends State<SwitchBtn1> {
  /// Current value of the switch.
  late bool lightVal = widget.currentLightVal;

  /// Gets the current value of the switch.
  bool getCurrentState() {
    return lightVal;
  }

  /// Changes the state based on the function [widget.onPressed].
  void changeState() {
    setState(() {
      widget.onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    lightVal = widget.currentLightVal;
    return TextButton(
      onPressed: (() {
        widget.onPressed();
      }),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
        overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 0, bottom: 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.iconData,
                  color: Color.fromARGB(255, 136, 136, 136),
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
                Switch(
                  value: lightVal,
                  activeColor: widget.switchActiveClr,
                  activeTrackColor: widget.switchActiveClr,
                  thumbColor:
                      MaterialStatePropertyAll<Color>(widget.thumbActiveClr),
                  onChanged: (bool val) {
                    widget.onPressed();
                  },
                )
              ],
            ),
            if (widget.tertiaryText != "")
              Row(
                children: [
                  Icon(
                    widget.iconData,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: RichText(
                        text: TextSpan(
                          text: widget.tertiaryText,
                          style: TextStyle(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 91, 91, 91),
                              height: 1.2),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
