import 'package:flutter/material.dart';

/// A widget that displays the description of a community.
class CommunityAboutDesc extends StatelessWidget {
  const CommunityAboutDesc({
    Key? key,
    required this.communityName,
    required this.communityDesc,
  }) : super(key: key);

  /// The name of the community.
  final String communityName;

  /// The description of the community.
  final String communityDesc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.w700),
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  communityDesc,
                  softWrap: true,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
