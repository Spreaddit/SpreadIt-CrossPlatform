import 'package:flutter/material.dart';

class ModalBottomBar extends StatelessWidget {
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
