import 'package:flutter/material.dart';

/// A custom tab bar widget.
///
/// This widget displays tabs horizontally with customizable titles.
///
/// Example usage:
/// ```dart
/// CustomBar(
///   onIndexChanged: (index) {
///     // Handle tab selection
///   },
///   tabs: [
///     'Tab 1',
///     'Tab 2',
///     'Tab 3',
///   ],
/// )
/// ```
class CustomBar extends StatefulWidget {
  /// Callback function triggered when a tab is selected.
  final ValueChanged<int> onIndexChanged;

  /// The list of tab titles.
  final List<String> tabs;

  /// Creates a custom tab bar.
  ///
  /// The [onIndexChanged] and [tabs] parameters are required.
  const CustomBar({
    Key? key,
    required this.onIndexChanged,
    required this.tabs,
  }) : super(key: key);

  @override
  _CustomBarState createState() => _CustomBarState();
}

class _CustomBarState extends State<CustomBar> {
  int _selectedIndex = 0;

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
    print('Index changed to: $index');
    widget.onIndexChanged(index);
  }

  Widget _buildTab(int index) {
    final isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () => _handleIndexChanged(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Text(
            widget.tabs[index],
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.blue : Colors.black,
            ),
          ),
          SizedBox(height: 10),
          if (index >= widget.tabs.length - 4)
            Container(
              height: isSelected ? 4.0 : 0,
              color: isSelected ? Colors.blue : Colors.transparent,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.tabs.length,
          (index) => Expanded(
            child: _buildTab(index),
          ),
        ),
      ),
    );
  }
}
