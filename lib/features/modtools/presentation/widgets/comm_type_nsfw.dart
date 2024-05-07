import 'package:flutter/material.dart';

/// Represents a switch widget for toggling the NSFW (Not Safe For Work) status of a community.
///
/// This widget provides a switch toggle to mark a community as 18+ or not.
///
/// Required parameters:
/// - [communityName]: The name of the community.
/// - [onTypeChanged]: Callback function invoked when the NSFW status is changed.
/// - [communityInfo]: Information about the community, including the current NSFW status.
class CommunityNSFWSwitch extends StatefulWidget {
  const CommunityNSFWSwitch({
    Key? key,
    required this.communityName,
    required this.onTypeChanged,
    required this.communityInfo,
  }) : super(key: key);

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
