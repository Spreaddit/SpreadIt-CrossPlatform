import 'package:flutter/material.dart';

class CustomSnackBarAction extends SnackBarAction {
  final IconData? icon;
  final String? imagePath;

  const CustomSnackBarAction({
    required VoidCallback onPressed,
    required String label,
    this.icon,
    this.imagePath,
  }) : super(
          onPressed: onPressed,
          label: label,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) 
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(icon),
              ),
            if (imagePath != null) 
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Image.asset(
                  imagePath!,
                  width: 15,
                  height: 15,
                ),
              ),
      ]
    );
  }
}