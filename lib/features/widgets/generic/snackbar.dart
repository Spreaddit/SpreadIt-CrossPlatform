import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './custom_snackbar_action.dart';

class CustomSnackbar {

  final String content;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final String? label;
  final int? duration;
  final IconData? icon;
  final String?imagePath;


  const CustomSnackbar({
    required this.content,
    this.backgroundColor,
    this.onPressed,
    this.duration,
    this.label,
    this.icon,
    this.imagePath,
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
          CustomSnackBarAction(
            label: label!,
            onPressed: onPressed!,
            icon: icon!,
            imagePath: imagePath) 
            : null
       )
           ,);
  }
}