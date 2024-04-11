import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';
import '../../data/violation_and_sub_violations.dart';

class SubReportSection extends StatefulWidget {
  SubReportSection({
    Key? key,
    required this.communityName,
    required this.selectedIndex,
    required this.onIndexChange,
    this.isReportingUser = false,
  }) : super(key: key);

  final String communityName;
  final int selectedIndex;
  final bool isReportingUser;
  final Function(int) onIndexChange;

  @override
  State<SubReportSection> createState() => _SubReportSectionState();
}

class _SubReportSectionState extends State<SubReportSection> {
  List<dynamic> communityRules = [];
  int listItemCount = 0;
  int selectedRadioIndex = -1;
  List<Map<String, dynamic>> selectedViolationsList = [];

  @override
  void initState() {
    super.initState();
    if (widget.isReportingUser) {
      selectedViolationsList = userViolationsList;
    } else {
      selectedViolationsList = subViolationsList;
    }
    if (widget.selectedIndex == 0 && !widget.isReportingUser) {
      fetchData();
    } else {
      listItemCount =
          selectedViolationsList[widget.selectedIndex]["subViolations"].length;
    }
  }

  Future<void> fetchData() async {
    var communityData = await getCommunityInfo(widget.communityName);
    setState(() {
      communityRules = communityData["rules"];
      listItemCount = communityRules.length;
      selectedViolationsList[0]["subViolations"] =
          List.generate(communityRules.length, (index) => "");
      for (int i = 0; i < communityRules.length; i++) {
        selectedViolationsList[0]["subViolations"][i] = communityRules[i]["title"];
      }
    });
  }

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
                      selectedViolationsList[widget.selectedIndex]["mainViolation"],
                      softWrap: true,
                      style: TextStyle(fontSize: 17, height: 1),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: listItemCount,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(selectedViolationsList[widget.selectedIndex]
                            ["subViolations"][index]),
                        value: index,
                        groupValue: selectedRadioIndex,
                        onChanged: (int? value) {
                          setState(() {
                            selectedRadioIndex = value ?? selectedRadioIndex;
                            selectedViolationsList[widget.selectedIndex]
                                ["subViolations"][index];
                            widget.onIndexChange(selectedRadioIndex);
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }),
    );
  }
}
