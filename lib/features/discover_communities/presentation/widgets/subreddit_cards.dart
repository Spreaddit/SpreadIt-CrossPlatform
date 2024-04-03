import 'package:flutter/material.dart';

class SubredditCard extends StatelessWidget {
  final int index;
  final String title;
  final String description;
  final int numberOfMembers;

  const SubredditCard({
    Key? key,
    required this.index,
    required this.title,
    required this.description,
    required this.numberOfMembers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text('$index'),
        title: Text(title),
        subtitle: Text(description),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$numberOfMembers members'),
            ElevatedButton(
              onPressed: () {
                // Implement join button functionality here
              },
              child: Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}
