import 'package:flutter/material.dart';
import 'switch_type_1.dart';

class SwitchSection extends StatefulWidget {
  const SwitchSection({
    Key? key,
  }) : super(key: key);

  @override
  State<SwitchSection> createState() => _SwitchSectionState();
}

class _SwitchSectionState extends State<SwitchSection> {
  final GlobalKey<SwitchBtn1State> _childKey =
      GlobalKey<SwitchBtn1State>();
  bool? _visibilitySetting = false;
  @override
  Widget build(BuildContext context) {
    _visibilitySetting = _childKey.currentState?.getCurrentState();
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {},
          child: SwitchBtn1(
            key: _childKey,
            iconData: Icons.account_circle_outlined,
            mainText: "Allow people to follow you",
            onPressed: (() {
              setState(() {
                _visibilitySetting = _childKey.currentState?.getCurrentState();
              });
            }),
            tertiaryText:
                "Followers will be notified about posts you make to your profile and see them in their home feed.",
          ),
        ),
        Visibility(
          visible: _visibilitySetting ?? false,
          maintainState: true,
          child: SwitchBtn1(
            iconData: Icons.group_outlined,
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
