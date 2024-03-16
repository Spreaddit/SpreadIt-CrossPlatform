import 'package:flutter/material.dart';

class CreateCommunityPage extends StatefulWidget {
  @override
  State<CreateCommunityPage> createState() => _CreateCommunityPageState();
}

class _CreateCommunityPageState extends State<CreateCommunityPage> {
  final communityType = [
    'Public',
    'Anyone can view post, and comment to this community'
  ];

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
              child: Text(communityType.join(', ')),
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
          child: ListView.builder(
            itemCount: communityType.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(communityType[index]),
                onTap: () {
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}
