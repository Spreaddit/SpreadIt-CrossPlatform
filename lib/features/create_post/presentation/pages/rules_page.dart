import 'package:flutter/material.dart';
import '../../../generic_widgets/button.dart';
import '../widgets/header_and_footer_widgets/buttonless_header.dart';
import '../widgets/expanded_rules.dart';


class CommunityRules extends StatefulWidget {
  const CommunityRules({Key? key}) : super(key: key);

  @override
  State<CommunityRules> createState() => _CommunityRulesState();
}

class _CommunityRulesState extends State<CommunityRules> {

  List<Map<String, dynamic>> rulesList = [
    {
      'title': 'Hate won\'t be tolerated',
      'body': 'Hate, personal insults and incitinng violence are all against our rules',
    },
    {
      'title':'Content quality',
      'body':'The moderators reserve the right to remove any content if it is deemed to be too low quality for this subreddit',
    },
    {
      'title': 'Personal insults',
      'body': 'We don\'t tolerate personal insults in this community especially if those insults are come as part of a heated argument'
    },
    {
      'title': 'All content must be related to programming',
    },
    {
      'title': 'No NSFW content',
      'body':' Elli haynazzel hagat keda hamawweto',
    },

  ];

  void navigateToFinalContentPage() {
    Navigator.of(context).pushNamed('/final-content-page');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ButtonlesHeader(
            text: "Community rules",
            onIconPress: navigateToFinalContentPage,
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
            itemCount: rulesList.length,
            itemBuilder: (context, index) {
              return ExpandableListWidget(
                title: rulesList[index]['title'],
                body: rulesList[index]['body'],
                );
              },
          ),
        ),
        //Spacer(),
        Button(
          onPressed: navigateToFinalContentPage,
          text: 'I understand',
          backgroundColor: Color.fromARGB(255, 13, 71, 161),
          foregroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

/* TODOs 
a3mel el api elli byfetch el rules aslan  */

 