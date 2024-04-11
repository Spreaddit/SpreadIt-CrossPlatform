import 'package:flutter/material.dart';

/// A button widget used for navigating to another page.
class ToPageBtn extends StatefulWidget {
  /// Creates a custom button widget.
  ///
  /// This is a template for buttons in the Settings page and sub-pages 
  /// that are used to navigate to other pages.
  ///
  /// Parameters:
  /// - [iconData] : [IconData] The icon data for the primary icon [required].
  /// - [mainText] : [String] The main text displayed on the button [required].
  /// - [onPressed] : [VoidCallback] Callback function invoked when the button is pressed [required].
  /// - [secondaryIconData] : [IconData] The icon data for the secondary icon (default is [Icons.arrow_forward]).
  /// - [secondaryText] : [String] The optional secondary text displayed below the main text (default is an empty string).
  /// - [tertiaryText] : [String] The optional tertiary text displayed below the secondary text (default is an empty string).
  const ToPageBtn({
    Key? key,
    required this.iconData,
    required this.mainText,
    required this.onPressed,
    this.secondaryIconData = Icons.arrow_forward,
    this.secondaryText = "",
    this.tertiaryText = "",
  }) : super(key: key);

  final IconData iconData;
  final IconData secondaryIconData;
  final VoidCallback onPressed;
  final String mainText;
  final String secondaryText;
  final String tertiaryText;

  @override
  State<ToPageBtn> createState() => _ToPageBtnState();
}

/// [ToPageBtn] state.
class _ToPageBtnState extends State<ToPageBtn> {
  @override
  Widget build(BuildContext context) {
    String optionalText = widget.secondaryText;

    return TextButton(
      onPressed: (() => widget.onPressed()),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
        overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 7, bottom: 7),
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
                      if (optionalText != "")
                        TextSpan(
                            text: "\n$optionalText",
                            style: TextStyle(
                                fontSize: 15,
                                color: const Color.fromARGB(255, 91, 91, 91),
                                height: 1.25)),
                    ]),
                    softWrap: true,
                  ),
                ),
                Icon(widget.secondaryIconData,
                    color: Color.fromARGB(255, 104, 103, 103)),
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
                              height: 1),
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
