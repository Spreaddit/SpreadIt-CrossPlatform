import 'package:flutter/material.dart';

/// A modal bottom bar widget that displays a button and optional extra text about the report choice.
class ModalBottomBar extends StatelessWidget {
  /// Creates a modal bottom bar.
  ///
  /// The [buttonText] parameter is required and specifies the text to be displayed on the button.
  ///
  /// The [onPressed] parameter is a callback function that will be called when the button is pressed.
  ///
  /// The [extraTextTitle] parameter is an optional string that specifies the title of the extra text section.
  ///
  /// The [extraText] parameter is an optional string that specifies the extra text to be displayed.
  ModalBottomBar({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.extraTextTitle = "",
    this.extraText = "",
  }) : super(key: key);

  final String buttonText;
  final Function? onPressed;
  final String extraTextTitle;
  final String extraText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (extraTextTitle != "") Divider(),
          if (extraTextTitle != "")
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                extraTextTitle,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          if (extraTextTitle != "")
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                extraText,
                softWrap: true,
                style: TextStyle(),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: (onPressed == null)
                      ? null
                      : () {
                          onPressed!();
                        },
                  child: Text(buttonText),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
