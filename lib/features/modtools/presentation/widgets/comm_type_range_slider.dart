import 'package:flutter/material.dart';

class CommunityRangeSlider extends StatefulWidget {
  CommunityRangeSlider(
      {Key? key,
      required this.communityName,
      required this.onTypeChanged,
      required this.communityInfo})
      : super(key: key);

  final String communityName;
  final Function onTypeChanged;
  final Map<String, dynamic> communityInfo;

  @override
  State<CommunityRangeSlider> createState() => CommunityRangeSliderState();
}

class CommunityRangeSliderState extends State<CommunityRangeSlider> {
  var communityTypeText = {
    "Public": "Anyone can see and participate in this community.",
    "Restricted":
        "Anyone can see, join or vote in this community, but you control who posts and comments.",
    "Private":
        "Only approved members can see and participate in this community.",
  };
  var communityTypeIdx = {
    "Public": 0.0,
    "Restricted": 1.0,
    "Private": 2.0,
  };
  double initialVal = 0;
  double currentRangeValue = 0;
  bool isTypeChanged = false;
  String currentType = "Public";
  bool initDone = false;

  @override
  void initState() {
    super.initState();
    initialVal = communityTypeIdx[widget.communityInfo['communityType']] ?? 0;
    currentRangeValue = initialVal;
    currentType = widget.communityInfo['communityType'];
  }

  String getCommunityType() {
    return currentType;
  }

  String _setCurrentType(double value) {
    switch (value.toInt()) {
      case 0:
        return "Public";
      case 1:
        return "Restricted";
      case 2:
        return "Private";
      default:
        return "Public";
    }
  }

  Color _getColorForValue(double value) {
    switch (value.toInt()) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Slider(
            min: 0,
            max: 2,
            value: currentRangeValue,
            divisions: 2,
            onChanged: (double values) {
              setState(() {
                currentRangeValue = values;
                currentType = _setCurrentType(values);
                isTypeChanged = (currentRangeValue != initialVal);
              });
              widget.onTypeChanged();
            },
            activeColor: _getColorForValue(currentRangeValue),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentType,
                  style: TextStyle(
                    color: _getColorForValue(currentRangeValue),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  communityTypeText[currentType] ?? "",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
