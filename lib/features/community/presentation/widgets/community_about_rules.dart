import 'package:flutter/material.dart';

/// A widget that displays the rules of a community.
class CommunityAboutRules extends StatefulWidget {
  /// The name of the community.
  final String communityName;

  /// Creates a [CommunityAboutRules] widget.
  CommunityAboutRules(
      {Key? key, required this.communityName, required this.communityRules})
      : super(key: key);

  final List<dynamic> communityRules;

  @override
  State<CommunityAboutRules> createState() => _CommunityAboutRulesState();
}

class _CommunityAboutRulesState extends State<CommunityAboutRules> {
  List<dynamic> communityRules = [];
  List<bool> expansionState = [];

  @override
  void initState() {
    super.initState();
    communityRules = widget.communityRules;
    expansionState = List.filled(communityRules.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "SubSpreddit Rules",
                  style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w700),
                ),
              ),
              Divider(),
              ExpansionPanelList(
                dividerColor: Colors.transparent,
                elevation: 0,
                materialGapSize: 0,
                expandedHeaderPadding: EdgeInsets.all(0),
                expansionCallback: (int panelIndex, bool isExpanded) {
                  setState(() {
                    expansionState[panelIndex] = isExpanded;
                  });
                },
                children: communityRules.map<ExpansionPanel>((rule) {
                  return ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return Column(
                        children: [
                          if (communityRules.indexOf(rule) != 0) Divider(),
                          ListTile(
                            title: Text(
                              "${communityRules.indexOf(rule) + 1}. ${rule["title"]}",
                              softWrap: true,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      );
                    },
                    body: Column(
                      children: [
                        ListTile(
                          title: Text(
                            rule["description"],
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    isExpanded: expansionState[communityRules.indexOf(rule)],
                    canTapOnHeader: true,
                  );
                }).toList(),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
