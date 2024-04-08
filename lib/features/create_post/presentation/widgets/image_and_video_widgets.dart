import 'package:flutter/material.dart';
import 'dart:io';

class ImageOrVideoWidget extends StatefulWidget {

  final File imageOrVideo;
  final VoidCallback onIconPress;

  const ImageOrVideoWidget({
    required this.imageOrVideo,
    required this.onIconPress,
  });

  @override
  State<ImageOrVideoWidget> createState() => _ImageOrVideoWidgetState();
}

class _ImageOrVideoWidgetState extends State<ImageOrVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
          alignment: Alignment.center,
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(widget.imageOrVideo),
              fit:BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
           icon: Icon(Icons.cancel),
           onPressed: widget.onIconPress,
         ),
        ),
      ],
    );
  }
}