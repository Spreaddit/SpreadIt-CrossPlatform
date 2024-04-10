import 'package:flutter/material.dart';

class ModalBottomBar extends StatelessWidget {
  ModalBottomBar({Key? key, required this.buttonText, required this.onPressed})
      : super(key: key);

  final String buttonText;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
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
    );
  }
}
