import 'package:flutter/material.dart';

/// [ExpandableListWidget] : a template of how the rules and their description will be displayed in the rules page

class ExpandableListWidget extends StatefulWidget {
  final String? title;
  final String? description;

  const ExpandableListWidget({
    required this.title,
    this.description,
  });

  @override
  _ExpandableListWidgetState createState() => _ExpandableListWidgetState();
}

class _ExpandableListWidgetState extends State<ExpandableListWidget> {

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (widget.description?.isNotEmpty ?? false)
                ? () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  }
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    widget.title!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.description?.isNotEmpty ?? false)
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 24,
                  ),
              ],
            ),
          ),
          if (_isExpanded)
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(widget.description!), 
              ),
            ),
        ],
      ),
    );
  }
}
