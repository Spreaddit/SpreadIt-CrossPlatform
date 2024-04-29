import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_community_info.dart';

class CommunityNSFWSwitch extends StatefulWidget {
  CommunityNSFWSwitch(
      {Key? key,
      required this.communityName,
      required this.onTypeChanged,
      required this.communityInfo})
      : super(key: key);

  final String communityName;
  final Function onTypeChanged;
  final Map<String, dynamic> communityInfo;

  @override
  State<CommunityNSFWSwitch> createState() => CommunityNSFWSwitchState();
}

class CommunityNSFWSwitchState extends State<CommunityNSFWSwitch> {
  bool isNSFW = false;
  bool isNSFWChanged = false;
  bool initDone = false;
  bool initialVal = false;
  Future<Map<String, dynamic>?>? communityInfo;

  @override
  void initState() {
    super.initState();
    initialVal = widget.communityInfo['is18plus'];
    isNSFW = initialVal;
    fetchData();
  }

  void fetchData() async {
    communityInfo = getModCommunityInfo(widget.communityName);
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        '18+ community',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      value: isNSFW,
      onChanged: (bool value) {
        setState(() {
          isNSFW = value;
          isNSFWChanged = isNSFW != initialVal;
        });
        widget.onTypeChanged();
      },
    );
  }
}
