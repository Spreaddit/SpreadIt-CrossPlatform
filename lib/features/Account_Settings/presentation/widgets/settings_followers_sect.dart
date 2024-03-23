import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'switch_type_1.dart';
import '../data/data_source/api_allow_follow_data.dart';

class SwitchSection extends StatefulWidget {
  const SwitchSection({
    Key? key,
  }) : super(key: key);

  @override
  State<SwitchSection> createState() => _SwitchSectionState();
}

class _SwitchSectionState extends State<SwitchSection> {
  //final GlobalKey<SwitchBtn1State> _childKey = GlobalKey<SwitchBtn1State>();

  late bool allowFollow = false;
  late Map<String, dynamic> jsonData;
  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    var data = await getData(); // Await the result of getData()
    setState(() {
      jsonData = data; // Update blockedAccountsList with fetched data
      allowFollow = jsonData['allowFollow'];
    });
  }

  Future<void> stateSetter() async {
    jsonData['allowFollow'] = !allowFollow;
    var result = await updateData(
        blkedList: jsonData['blockedAccounts'],
        updatedVal: jsonData['allowFollow']);
    if (result == 200) {
      setState(() {
        allowFollow = !allowFollow;
      });
    }
    else{
      CustomSnackbar(content: "Failed to update").show(context);
    }
  }

  //bool? _visibilitySetting = false;
  @override
  Widget build(BuildContext context) {
    //_visibilitySetting = _childKey.currentState?.getCurrentState();
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: SwitchBtn1(
            //key: _childKey,
            iconData: Icons.account_circle_outlined,
            currentLightVal: allowFollow,
            mainText: "Allow people to follow you",
            onPressed: (() {
              stateSetter();
            }),
            tertiaryText:
                "Followers will be notified about posts you make to your profile and see them in their home feed.",
          ),
        ),
        Visibility(
          visible: allowFollow,
          maintainState: true,
          child: SwitchBtn1(
            iconData: Icons.group_outlined,
            currentLightVal: false,
            mainText: "Show your follower count",
            onPressed: (() {}),
            tertiaryText:
                "Turning this off hides your follower count on your profile from others",
          ),
        ),
      ],
    );
  }
}
