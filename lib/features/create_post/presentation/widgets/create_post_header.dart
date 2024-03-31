import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CreatePostHeader extends StatefulWidget {

  final String buttonText;
  final VoidCallback onPressed;
  
  const CreatePostHeader({
    required this.buttonText,
    required this.onPressed,
  });

  @override
  State<CreatePostHeader> createState() => _CreatePostHeaderState();
}

class _CreatePostHeaderState extends State<CreatePostHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 40,
          width: 40,
          child: IconButton(
            icon: Icon(
              Icons.clear_rounded,
              size: 40),
            onPressed: () {},
          ),
        ),
      Container(
          margin:EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed:widget.onPressed,
            child: Text(widget.buttonText),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              foregroundColor: Colors.white,
              fixedSize: Size(80,20),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              )
            )
            ),
        ),
      ],
    );
  }
}