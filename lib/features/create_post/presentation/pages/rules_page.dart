import 'package:flutter/material.dart';
import '../../../generic_widgets/button.dart';
import '../widgets/buttonless_header.dart';
import '../widgets/expanded_rules.dart';


class CommunityRules extends StatefulWidget {
  const CommunityRules({Key? key}) : super(key: key);

  @override
  State<CommunityRules> createState() => _CommunityRulesState();
}

class _CommunityRulesState extends State<CommunityRules> {

  List <dynamic> rules = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ButtonlesHeader(text: "Community rules"),
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
       /* Expanded(
          child: ListView(
            children: [
              ListTile(
                title: Text("the first rule"),
                trailing: IconButton(
                  onPressed:() {},
                  icon: Icon(Icons.arrow_drop_down)),
              ),
              ListTile(
                title: Text("the second rule"),
                trailing: IconButton(
                  onPressed:() {},
                  icon: Icon(Icons.arrow_drop_down)),
              ),
              ListTile(
                title: Text("the third rule"),
                trailing: IconButton(
                  onPressed:() {},
                  icon: Icon(Icons.arrow_drop_down)),
              ),
            ],
          ),
        )*/
        ExpandableListWidget(text:'rules',itemList: ['first rule', 'second rule', 'third rule']),
        ExpandableListWidget(text:'rules',itemList: ['fourth rule', 'fifth rule', 'sixth rule']),
        Spacer(),
        Button(onPressed: () {}, text: 'I understand', backgroundColor: Colors.blue, foregroundColor: Colors.white)
        ],
        ),
        );
  }
}

/* TODOs 
1) azabbat el expanded list di akhalliha zay mana 3ayza 
2)a3mel el api elli byfetch el rules aslan  */