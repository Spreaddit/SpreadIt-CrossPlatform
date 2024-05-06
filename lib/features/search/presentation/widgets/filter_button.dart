import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  
  final VoidCallback openBottomSheet;
  final String text;

  const FilterButton({
    required this.openBottomSheet,
    required this.text,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: ElevatedButton(
        onPressed: widget.openBottomSheet,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(3),
          backgroundColor: Colors.grey[200],
        ),
        child: Row(
          mainAxisSize : MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}