import 'package:flutter/material.dart';
import '../../../generic_widgets/small_custom_button.dart';

/// [showDiscardButtomSheet] : a function which displays the buttom sheet which appears upon canceling the creation of a post
/// it give the user the option to choose between discarding the post or saving th draft

void showDiscardButtomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.all(15),
          height: 150,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Save draft',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Save your changes and come back to finish your post later',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallButton(
                      buttonText: 'Discard',
                      onPressed: () {
                        returnToHomePage(context);
                      },
                      isEnabled: true,
                      width: 160,
                      height: 30,
                      backgroundColor: Color.fromARGB(255, 214, 214, 214),
                      foregroundColor: const Color.fromARGB(255, 138, 138, 138),
                    ),
                    SmallButton(
                      buttonText: 'Save',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      isEnabled: true,
                      width: 160,
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}

void returnToHomePage(BuildContext context) {
  Navigator.pop(context);
  Navigator.popAndPushNamed(context, '/home');
}
