import 'package:flutter/material.dart';
import '../../../generic_widgets/button.dart';
import '../widgets/header_and_footer_widgets/buttonless_header.dart';
import '../widgets/expanded_rules.dart';

/// the class [CommunityRules] displays the rules of the community to which the user posts. 
/// Each rule contains a [title] and may be extended to include its [description].

class CommunityRules extends StatefulWidget {
  final List<String?> communityRules;

  const CommunityRules({
    required this.communityRules,
  });

  @override
  State<CommunityRules> createState() => _CommunityRulesState();
}

class _CommunityRulesState extends State<CommunityRules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ButtonlesHeader(
            text: "Community rules",
            onIconPress: () {
              Navigator.pop(context);
            },
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'Rules are different for each community. Reviewing the rules can help you be more successful when posting or commenting on this community',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.communityRules.length,
              itemBuilder: (context, index) {
                return ExpandableListWidget(
                    title: widget.communityRules[index], //['title'],
                    description: widget.communityRules[index] //['description'],
                    );
              },
            ),
          ),
          //Spacer(),
          Button(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'I understand',
            backgroundColor: Color.fromARGB(255, 13, 71, 161),
            foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
