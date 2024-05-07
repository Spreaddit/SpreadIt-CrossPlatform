import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/modtools/presentation/pages/modtools_page.dart';

/// Represents a button to navigate to the mod tools page.
///
/// This button, when pressed, navigates to the mod tools page for a specific community.
///
/// Required parameters:
/// - [communityName]: The name of the community.
/// - [onReturnToCommunityPage]: Callback function invoked when returning to the community page.
class ModtoolsPageBtn extends StatelessWidget {
  const ModtoolsPageBtn({
    Key? key,
    required this.communityName,
    required this.onReturnToCommunityPage,
  }) : super(key: key);

  final String communityName;
  final Function onReturnToCommunityPage;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ModtoolsPage(
              communityName: communityName,
            ),
          ),
        ).then((value) => onReturnToCommunityPage());
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        'Mod Tools',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

