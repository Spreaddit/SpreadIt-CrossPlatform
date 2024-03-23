import 'package:flutter/material.dart';

class SwitchBtn2 extends StatefulWidget {
  const SwitchBtn2({
    Key? key,
    required this.filledIconData,
    required this.outlinedIconData,
    required this.mainText,
    required this.onPressed,
    this.switchActiveClr = const Color.fromARGB(255, 7, 116, 205),
    this.thumbActiveClr = Colors.white,
  }) : super(key: key);

  final IconData filledIconData;
  final IconData outlinedIconData;
  final Function onPressed;
  final Color switchActiveClr;
  final Color thumbActiveClr;
  final String mainText;

  @override
  State<SwitchBtn2> createState() => SwitchBtn2State();
}

class SwitchBtn2State extends State<SwitchBtn2> {
  bool lightVal = false;
  late IconData iconData;
  bool getCurrentState() {
    return lightVal;
  }

  void changeState() {
    setState(() {
      lightVal = !lightVal;
      iconData = (lightVal)? widget.filledIconData : widget.outlinedIconData;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    iconData = (lightVal)? widget.filledIconData : widget.outlinedIconData;
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
