import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'switch_type_1.dart';
import '../../data/data_source/api_allow_follow_data.dart';

/// A widget representing a section with 1 switches of type [SwitchBtn1].
///
/// The switch allowing people to follow the user is displayed in this section.
class FollowersSwitchSection extends StatefulWidget {
  /// Creates a switch section widget.
  const FollowersSwitchSection({
    Key? key,
    required this.allowFollow,
  }) : super(key: key);

  /// Represents whether following is allowed.
  final bool allowFollow;

  @override
  State<FollowersSwitchSection> createState() => _FollowersSwitchSectionState();
}

/// [FollowersSwitchSection] state.
class _FollowersSwitchSectionState extends State<FollowersSwitchSection> {
  /// Represents whether following is allowed.
  late bool allowFollow;

  @override
  void initState() {
    super.initState();
    allowFollow = widget.allowFollow;
  }

  /// Updates the state of the first switch.
  Future<void> stateSetter() async {
    setState(() {
      allowFollow = !allowFollow;
    });
    var result = await updateData(updatedVal: allowFollow);
    if (result == 200) {
    } else {
      setState(() {
        allowFollow = !allowFollow;
      });
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
      ],
    );
  }
}
