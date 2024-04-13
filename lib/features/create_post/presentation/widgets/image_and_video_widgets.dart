import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;


/// [ImageOrVideoWidget] : a template of how the images or videos will be displayed to the user upon upload

class ImageOrVideoWidget extends StatefulWidget {

  final File? imageOrVideo;
  final Uint8List? imageOrVideoWeb;
  final VoidCallback onIconPress;

  const ImageOrVideoWidget({
    required this.imageOrVideo,
    required this.imageOrVideoWeb,
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
            image: 
            !kIsWeb ?
              DecorationImage(
                image: FileImage(widget.imageOrVideo!),
                fit:BoxFit.cover,
              ) :
              DecorationImage(
                image:MemoryImage(widget.imageOrVideoWeb!),
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