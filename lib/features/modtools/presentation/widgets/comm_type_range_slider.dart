import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_community_info.dart';

class CommunityRangeSlider extends StatefulWidget {
  CommunityRangeSlider(
      {Key? key, required this.communityName, required this.onTypeChanged})
      : super(key: key);

  final String communityName;
  final Function onTypeChanged;

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
  late Future<Map<String, dynamic>> communityInfo;
  bool initDone = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    communityInfo = getModCommunityInfo(widget.communityName);
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
    return FutureBuilder(
        future: communityInfo,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoaderWidget(
                dotSize: 10,
                logoSize: 100,
              ),
            );
          } else if (snapshot.hasError) {
            CustomSnackbar(content: "Error ${snapshot.error}").show(context);
            return Text("");
          } else if (snapshot.hasData) {
            initialVal = communityTypeIdx[snapshot.data!['communityType']] ?? 0;
            if (!initDone) {
              currentRangeValue = initialVal;
              currentType = snapshot.data!['communityType'];
              initDone = true;
            }
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
          } else {
            CustomSnackbar(content: "Error: Couldn't fetch data").show(context);
            return Text("");
          }
        });
  }
}
