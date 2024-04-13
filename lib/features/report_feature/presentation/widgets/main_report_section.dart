import 'package:flutter/material.dart';

class MainReportSection extends StatefulWidget {
  const MainReportSection({Key? key, required this.mainReportOptions})
      : super(key: key);

  final List<Widget> mainReportOptions;

  @override
  State<MainReportSection> createState() => _MainReportSectionState();
}

class _MainReportSectionState extends State<MainReportSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 1,
          maxChildSize: 1,
          builder: (_, scrollController) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Thank you for looking out for yourself and your fellow redditors by reporting things that break the rules. Let us know what's happening and we'll look into it.",
                      softWrap: true,
                      style: TextStyle(fontSize: 17, height: 1),
                    ),
                  ),
                  Wrap(
                    children: widget.mainReportOptions,
                  ),
                ],
              ),
            );
          }),
    );
  }
}
