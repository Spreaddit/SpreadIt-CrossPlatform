import 'package:flutter/material.dart';

class PostOptionsBox extends StatefulWidget {
  final Function(String) onOptionSelected;
  final String initialOption;

  const PostOptionsBox(
      {Key? key, required this.onOptionSelected, required this.initialOption})
      : super(key: key);

  @override
  _PostOptionsBoxState createState() => _PostOptionsBoxState();
}

class _PostOptionsBoxState extends State<PostOptionsBox> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.initialOption;
  }

  @override
  void didUpdateWidget(covariant PostOptionsBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialOption != _selectedOption) {
      setState(() {
        _selectedOption = widget.initialOption;
      });
    }
  }

  Future<void> _showOptionsModal(BuildContext context) async {
    final selectedOption = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('any'),
              onTap: () {
                Navigator.pop(context, 'any');
              },
            ),
            ListTile(
              title: Text('text posts only'),
              onTap: () {
                Navigator.pop(context, 'text posts only');
              },
            ),
            ListTile(
              title: Text('links only'),
              onTap: () {
                Navigator.pop(context, 'links only');
              },
            ),
          ],
        );
      },
    );

    if (selectedOption != null) {
      setState(() {
        _selectedOption = selectedOption;
      });
      widget.onOptionSelected(selectedOption);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _showOptionsModal(context);
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.5)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Post Options',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$_selectedOption',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
