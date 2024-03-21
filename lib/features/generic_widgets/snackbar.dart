import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
          ),
        behavior: SnackBarBehavior.floating,
        duration: duration != null ?
          Duration(milliseconds: duration!)
          : Duration(milliseconds: 2000),
        action: label != null && onPressed != null ?
          SnackBarAction(
            label: label!,
            onPressed: onPressed!,
            ) 
            : null
       )
           ,);
  }
}
