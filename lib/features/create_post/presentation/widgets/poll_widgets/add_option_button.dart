import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


/// [AddOptionsButton] : a button which allows the user to add another option to his poll

class AddOptionButton extends StatefulWidget {

  final VoidCallback onPressed;

  const AddOptionButton({
    required this.onPressed,
  });

  @override
  State<AddOptionButton> createState() => _PollOptionState();
}

class _PollOptionState extends State<AddOptionButton> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(10),
      height: 45,
      color: Colors.grey[200],
      child:Row(
        children:[ 
          Icon(Icons.add),
          InkWell(
            onTap: widget.onPressed,
            child: Text(
              'Add option',
              style: TextStyle(
                fontSize: 15
              ),
            ),
          ),
        ], 
      ),
    );
  }
}