import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'switch_type_1.dart';
import '../../data/data_source/api_allow_follow_data.dart';

/// A widget representing a section with two switches of type [SwitchBtn1].
///
/// The first switch controls the visibility of the second switch.
class SwitchSection extends StatefulWidget {
  /// Creates a switch section widget.
  const SwitchSection({
    Key? key,
  }) : super(key: key);

  @override
  State<SwitchSection> createState() => SwitchSectionState();
}

/// [SwitchSection] state.
class SwitchSectionState extends State<SwitchSection> {
  /// Represents whether following is allowed.
  late bool allowFollow = false;

  /// Holds data fetched for user information.
  late Map<String, dynamic> jsonData;

  /// Calls the [fetchData] method to fetch user information.
  @override
  void initState() {
    super.initState();
    setState(() {
      fetchData();
    });
  }

  /// Fetches data from the API.
  Future<void> fetchData() async {
    var data = await getData(); // Await the result of getData()
    setState(() {
      jsonData = data; // Update blockedAccountsList with fetched data
      allowFollow = jsonData['allowFollow'];
    });
  }

  /// Updates the state of the first switch.
  Future<void> stateSetter() async {
    jsonData['allowFollow'] = !allowFollow;
    var result = await updateData(
        blkedList: jsonData['blockedAccounts'],
        updatedVal: jsonData['allowFollow']);
    if (result == 200) {
      setState(() {
        allowFollow = !allowFollow;
      });
    } else {
      CustomSnackbar(content: "Failed to update").show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: SwitchBtn1(
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
