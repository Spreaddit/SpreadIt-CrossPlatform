import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_community_info.dart';

class CommunityNSFWSwitch extends StatefulWidget {
  CommunityNSFWSwitch(
      {Key? key, required this.communityName, required this.onTypeChanged})
      : super(key: key);

  final String communityName;
  final Function onTypeChanged;

  @override
  State<CommunityNSFWSwitch> createState() => CommunityNSFWSwitchState();
}

class CommunityNSFWSwitchState extends State<CommunityNSFWSwitch> {
  bool isNSFW = false;
  bool isNSFWChanged = false;
  bool initDone = false;
  late Future<Map<String, dynamic>> communityInfo;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    communityInfo = getModCommunityInfo(widget.communityName);
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
            bool initialVal = snapshot.data!['is18plus'];
            if (!initDone) {
              isNSFW = initialVal;
              initDone = true;
            }
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
          } else {
            CustomSnackbar(content: "Error: Couldn't fetch data").show(context);
            return Text("");
          }
        });
  }
}
