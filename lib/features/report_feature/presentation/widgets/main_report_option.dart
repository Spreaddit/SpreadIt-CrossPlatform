import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/community/data/api_community_info.dart';

/// A widget that represents a main report option.
class MainReportOption extends StatefulWidget {
  /// The name of the community.
  final String communityName;

  /// The text of the option.
  final String optionText;

  /// Indicates whether the option has an image.
  final bool optionHasImage;

  /// The index of the option.
  final int index;

  /// The index of the selected container.
  final int selectedContainerIndex;

  /// A callback function that is called when the option is selected.
  final Function onSelect;

  /// Creates a [MainReportOption] widget.
  MainReportOption({
    Key? key,
    required this.communityName,
    required this.optionText,
    required this.index,
    required this.selectedContainerIndex,
    required this.onSelect,
    this.optionHasImage = false,
  }) : super(key: key);

  @override
  State<MainReportOption> createState() => _MainReportOptionState();
}

class _MainReportOptionState extends State<MainReportOption> {
  String communityImageLink = "";
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isSelected = (widget.index == widget.selectedContainerIndex);
    });
    if (widget.optionHasImage) {
      fetchData();
    }
  }

  void fetchData() async {
    var communityData = await getCommunityInfo(widget.communityName);
    setState(() {
      communityImageLink = communityData["image"];
    });
  }

  @override
  void didUpdateWidget(covariant MainReportOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      isSelected = (widget.index == widget.selectedContainerIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          widget.onSelect();
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.blueAccent
                : Color.fromARGB(255, 240, 238, 238),
            borderRadius: BorderRadius.circular(20), // Rounded border
          ),
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.optionHasImage)
                CircleAvatar(
                  radius: 10,
                  foregroundImage: (communityImageLink != "")
                      ? NetworkImage(communityImageLink)
                      : AssetImage("assets/images/LogoSpreadIt.png")
                          as ImageProvider,
                ),
              if (widget.optionHasImage)
                SizedBox(
                  width: 5,
                ),
              Text(
                widget.optionText,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
