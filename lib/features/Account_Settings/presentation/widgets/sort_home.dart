import 'package:flutter/material.dart';
import 'settings_btn_bottom_sheet.dart';

class SortHome extends StatefulWidget {
  SortHome({Key? key}) : super(key: key);

  final List<String> homeSort = [
    "best",
    "hot",
    "newposts",
    "top",
    "random",
    "recent",
  ];

  @override
  State<SortHome> createState() => _SortHomeState();
}

class _SortHomeState extends State<SortHome> {
  String? _selectedHomeSort = "";
  String? _tempSelectedHomeSort = "";
  late Map<String, dynamic> data;
  int result = 1;
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  void setHomeSort() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                // This is the small bar that appears at the top of the bottom sheet
                height: 4,
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Sort Home By',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.grey.withOpacity(0.5)),
                            ),
                            child: Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 4, 75, 133),
                              ),
                            ),
                            onPressed: () async {
                              setState(() {
                                _selectedHomeSort = _tempSelectedHomeSort;
                              });
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        "This information may be used to improve your recommendations",
                        style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 109, 109, 109),
                          height: 1.25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  RadioListTile<String>(
                    dense: true,
                    title: Transform.translate(
                      offset: const Offset(-12, 0),
                      child: Text(
                        widget.homeSort[0],
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    value: widget.homeSort[0],
                    groupValue: _tempSelectedHomeSort,
                    onChanged: (value) {
                      setModalState(() {
                        _tempSelectedHomeSort = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    dense: true,
                    title: Transform.translate(
                      offset: const Offset(-12, 0),
                      child: Text(
                        widget.homeSort[1],
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    value: widget.homeSort[1],
                    groupValue: _tempSelectedHomeSort,
                    onChanged: (value) {
                      setModalState(() {
                        _tempSelectedHomeSort = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    dense: true,
                    title: Transform.translate(
                      offset: const Offset(-12, 0),
                      child: Text(
                        widget.homeSort[2],
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    value: widget.homeSort[2],
                    groupValue: _tempSelectedHomeSort,
                    onChanged: (value) {
                      setModalState(() {
                        _tempSelectedHomeSort = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    dense: true,
                    title: Transform.translate(
                      offset: const Offset(-12, 0),
                      child: Text(
                        widget.homeSort[3],
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    value: widget.homeSort[3],
                    groupValue: _tempSelectedHomeSort,
                    onChanged: (value) {
                      setModalState(() {
                        _tempSelectedHomeSort = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    dense: true,
                    title: Transform.translate(
                      offset: const Offset(-12, 0),
                      child: Text(
                        widget.homeSort[4],
                        style: TextStyle(
                          fontSize: 17.5,
                        ),
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    activeColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    value: widget.homeSort[4],
                    groupValue: _tempSelectedHomeSort,
                    onChanged: (value) {
                      setModalState(() {
                        _tempSelectedHomeSort = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BottomModalBtn(
        iconData: Icons.person_outline,
        mainText: "Sort Home By",
        selection: _selectedHomeSort,
        onPressed: () {
          _tempSelectedHomeSort = _selectedHomeSort;
          setHomeSort();
        },
      );
    });
  }
}
