import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final List<IconData> icons;
  final List<String> text;
  final List<VoidCallback> onPressedList;

  CustomBottomSheet(
      {required this.icons, required this.text, required this.onPressedList});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: icons.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(icons[index]),
              title: Text(text[index]),
              onTap: () {
                onPressedList[index].call();
              },
            );
          },
        ),
      ),
    );
  }
}
