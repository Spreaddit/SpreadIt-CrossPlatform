import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {

  final String hintText;

  const CustomSearchBar({
    required this.hintText,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 214, 214, 214)
          ),
        child: SizedBox(
          height: 40,
          child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: widget.hintText,
                prefixIcon: Icon(Icons.search),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                )
              ),
          ),
        ),
      ),
    );
  }
}