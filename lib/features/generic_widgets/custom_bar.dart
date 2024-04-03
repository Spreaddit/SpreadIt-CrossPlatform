import 'package:flutter/material.dart';

class CustomBar extends StatefulWidget {
  final ValueChanged<int> onIndexChanged;
  final List<String> tabs;

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
    widget.onIndexChanged(index);
  }

  Widget _buildTab(int index) {
    final isSelected = index == _selectedIndex;
    return GestureDetector(
      onTap: () => _handleIndexChanged(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.tabs[index],
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 4),
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
    return SizedBox(
      height: kToolbarHeight,
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