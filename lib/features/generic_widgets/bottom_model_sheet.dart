import 'package:flutter/material.dart';


/// A custom bottom sheet widget with customizable items.
///
/// This widget displays a bottom sheet with a list of icons and text.
/// Each list item can have a leading icon, text, and an optional trailing icon.
/// Tapping on an item triggers the corresponding callback.
///
/// ```dart
/// CustomBottomSheet(
///   icons: [
///     Icons.star,
///     Icons.favorite,
///   ],
///   text: [
///     "Text 1",
///     "Text 2",
///   ],
///   onPressedList: [
///     () {
///       // Callback function 1
///     },
///     () {
///       // Callback function 2
///     },
///   ],
///   onTrailingPressedList: [
///     () {
///       // Trailing callback function 1
///     },
///     () {
///       // Trailing callback function 2
///     },
///   ],
///   trailingIcons: [
///     Icons.arrow_forward,
///     null, // 2nd item won't have a trailing icon
///   ],
///   colors: [
///     null,   // Text and icon color of first item will be default
///     Colors.red, // Text and icon color of second item will be red
///   ],
/// );
/// ```
///
class CustomBottomSheet extends StatelessWidget {
  /// The list of leading icons for each item.
  final List<IconData> icons;

  /// The list of text to display for each item.
  final List<String> text;

  /// The list of callbacks to trigger when an item is tapped.
  final List<VoidCallback> onPressedList;

  /// The list of trailing icons to display.
  final List<IconData?>? trailingIcons;

  /// The list of callbacks to trigger when a trailing icon is tapped.
  final List<VoidCallback?>? onTrailingPressedList;

  /// The list of colors for icons and text.
  final List<Color?>? colors;

  /// Creates a custom bottom sheet.
  ///
  /// The [icons], [text], and [onPressedList] parameters must not be null.
  /// The [trailingIcons], [onTrailingPressedList], and [colors] parameters are optional.
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
