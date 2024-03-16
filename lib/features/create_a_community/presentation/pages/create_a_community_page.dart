import 'package:flutter/material.dart';

class CreateCommunityPage extends StatefulWidget {
  @override
  State<CreateCommunityPage> createState() => _CreateCommunityPageState();
}

class _CreateCommunityPageState extends State<CreateCommunityPage> {
  final communityType = [
    'Public \n Anyone can view post, and comment to this community',
    'Private \n Only approved members can view and contribute to this community',
    'Restricted \n Only approved members can view this community',
  ];
  var selectedCommunityType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a community'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1.0, color: Colors.grey),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Community Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'r/Community_name',
              ),
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                'Community type',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: _onCommunityTypePress,
              child: Text(communityType[selectedCommunityType].split('\n')[0]),
            )
          ],
        ),
      ),
    );
  }

  void _onCommunityTypePress() async {
    await showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'Community type',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: communityType.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(communityType[index].split('\n')[0],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text(communityType[index].split('\n')[1],
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          )),
                      onTap: () {
                        _changeSelectedCommunity(index);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _changeSelectedCommunity(index) {
    setState(() {
      selectedCommunityType = index;
    });
  }
}
