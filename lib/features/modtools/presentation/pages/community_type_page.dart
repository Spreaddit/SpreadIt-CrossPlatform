import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/fail_to_fetch.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/loader/loader_widget.dart';
import 'package:spreadit_crossplatform/features/modtools/data/api_community_info.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/comm_type_nsfw.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/comm_type_range_slider.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/widgets/saving_appbar.dart';

/// Widget to manage community type settings.
class CommunityTypePage extends StatefulWidget {
  /// The name of the community.
  final String communityName;

  /// Constructor for [CommunityTypePage].
  const CommunityTypePage({Key? key, required this.communityName})
      : super(key: key);

  @override
  State<CommunityTypePage> createState() => _CommunityTypePageState();
}

class _CommunityTypePageState extends State<CommunityTypePage> {
  final GlobalKey<CommunityRangeSliderState> _rangeSliderKey =
      GlobalKey<CommunityRangeSliderState>();
  final GlobalKey<CommunityNSFWSwitchState> _nsfwSwitchSliderKey =
      GlobalKey<CommunityNSFWSwitchState>();

  Future<Map<String, dynamic>?>? communityInfo;

  bool changesOccured = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /// Fetches community info data.
  void fetchData() async {
    communityInfo = getModCommunityInfo(widget.communityName);
  }

  /// Checks if the community type or NSFW setting has changed.
  void isTypeOrNSFWChanged() {
    if (_rangeSliderKey.currentState!.isTypeChanged ||
        _nsfwSwitchSliderKey.currentState!.isNSFWChanged) {
      setState(() {
        changesOccured = true;
      });
    } else {
      setState(() {
        changesOccured = false;
      });
    }
  }

  /// Updates the community type and NSFW setting.
  void updateCommunityType() async {
    String communityType = _rangeSliderKey.currentState!.getCommunityType();
    bool isNSFW = _nsfwSwitchSliderKey.currentState!.isNSFW;
    int response = await updateModCommunityInfo(widget.communityName,
        communityType: communityType, is18plus: isNSFW);
    if (response == 200) {
      Navigator.pop(context);
      CustomSnackbar(content: "Community types updated").show(context);
    } else {
      CustomSnackbar(content: "Error updating Community types").show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SavingAppBar(
        title: "Community type",
        onSavePressed: changesOccured ? () => updateCommunityType() : null,
      ),
      body: FutureBuilder(
          future: communityInfo,
          builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: LoaderWidget(
                  dotSize: 10,
                  logoSize: 100,
                ),
              );
            } else if (snapshot.hasError) {
              return FailToFetchPage(
                  displayWidget: Center(
                child: Text("Error fetching data 😔"),
              ));
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  CommunityRangeSlider(
                    key: _rangeSliderKey,
                    communityName: widget.communityName,
                    onTypeChanged: isTypeOrNSFWChanged,
                    communityInfo: snapshot.data!,
                  ),
                  CommunityNSFWSwitch(
                    key: _nsfwSwitchSliderKey,
                    communityName: widget.communityName,
                    onTypeChanged: isTypeOrNSFWChanged,
                    communityInfo: snapshot.data!,
                  ),
                ],
              );
            } else {
              return FailToFetchPage(
                  displayWidget: Center(
                child: Text("Unknown error fetching data 🤔"),
              ));
            }
          }),
    );
  }
}
