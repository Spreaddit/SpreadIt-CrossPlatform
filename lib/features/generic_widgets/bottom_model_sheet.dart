import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final List<IconData> icons;
  final List<String> text;
  final List<VoidCallback> onPressedList;
  final List<IconData?>? trailingIcons;
  final List<VoidCallback?>? onTrailingPressedList;
  final List<Color?>? colors;

  CustomBottomSheet({
    required this.icons,
    required this.text,
    required this.onPressedList,
    this.trailingIcons,
    this.onTrailingPressedList,
    this.colors,
  });

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
              leading: Icon(
                icons[index],
                color: colors != null && index < colors!.length
                    ? colors![index]
                    : null,
              ),
              title: Text(
                text[index],
                style: TextStyle(color: colors != null && index < colors!.length
                    ? colors![index]
                    : null),
              ),
              onTap: onPressedList[index],
              trailing: trailingIcons != null &&
                      index < trailingIcons!.length &&
                      onTrailingPressedList != null &&
                      index < onTrailingPressedList!.length
                  ? GestureDetector(
                      onTap: onTrailingPressedList![index],
                      child: Icon(
                        trailingIcons![index],
                        color: colors != null && index < colors!.length
                            ? colors![index]
                            : null,
                      ),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
