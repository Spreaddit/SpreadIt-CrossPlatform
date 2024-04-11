import 'package:flutter/material.dart';


/// This class allows the creation of a custom snackbar to display messages to users upon action.
/// It takes the following parameters:
///  String [content] : the content displayed in the snackbar.
///  Color [backgroundColor] : the background color of the snackbar.
///  String [label] : a button within the snackbar.
///  VoidCallback [onPressed] : the action to be taken when the label is pressed.
///  int [duration] : the duration the snackbar remains on the screen before disappearing.
class CustomSnackbar {
  final String content;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final String? label;
  final int? duration;

  const CustomSnackbar({
    required this.content,
    this.backgroundColor,
    this.onPressed,
    this.duration,
    this.label,
  });

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          margin: EdgeInsets.all(10),
          content: Text(content),
          backgroundColor: backgroundColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          behavior: SnackBarBehavior.floating,
          duration: duration != null
              ? Duration(milliseconds: duration!)
              : Duration(milliseconds: 2000),
          action: label != null && onPressed != null
              ? SnackBarAction(
                  label: label!,
                  onPressed: onPressed!,
                )
              : null),
    );
  }
}
