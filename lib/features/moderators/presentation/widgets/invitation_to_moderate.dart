import 'package:flutter/material.dart';

List<Map<String, String>> communities = [
  {
    'name': 'Icon 1',
    'url': 'https://via.placeholder.com/150',
  },
  {
    'name': 'Icon 2',
    'url': 'https://via.placeholder.com/150',
  },
  {
    'name': 'Icon 3',
    'url': 'https://via.placeholder.com/150',
  },
  // Add more icons as needed
];

void _showModalBottomSheetInvite(BuildContext context) {
  Map<String, String>? _selectedCommunity;
  bool _managePostsClicked = false;
  bool _manageUsersClicked = false;
  bool _manageSettingsClicked = false;

  late TextEditingController _messageController;

  @override

  /*void initState() {
                _messageController =
                    TextEditingController(text: 'Initial Value');
              }*/

  void dispose() {
    _messageController.dispose();
  }

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose a community:',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 16.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: communities.map((community) {
                      bool isSelected = _selectedCommunity == community;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCommunity = community;
                              _messageController = TextEditingController(
                                  text:
                                      'I invite you to be a moderator of (${community["name"]}) [//route]');
                            });
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                backgroundImage:
                                    NetworkImage(community['url']!),
                                child: CircleAvatar(
                                  radius: isSelected ? 25 : 30,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(community['url']!),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.transparent,
                                        width: isSelected ? 4.0 : 0.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(community['name']!),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.0),
                if (_selectedCommunity != null) ...[
                  /* Text(
                                'Selected Community: ${_selectedCommunity!['name']}',
                                style: TextStyle(fontSize: 16.0),
                              ),*/
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _managePostsClicked = !_managePostsClicked;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return _managePostsClicked
                                  ? Colors.blue
                                  : Colors.grey;
                            },
                          ),
                        ),
                        child: Text('Manage posts and comments'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _manageUsersClicked = !_manageUsersClicked;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return _manageUsersClicked
                                  ? Colors.blue
                                  : Colors.grey;
                            },
                          ),
                        ),
                        child: Text('Manage users'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _manageSettingsClicked = !_manageSettingsClicked;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              return _manageSettingsClicked
                                  ? Colors.blue
                                  : Colors.grey;
                            },
                          ),
                        ),
                        child: Text('Manage settings'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController, // Set controller here
                          onChanged: (value) {
                            setState(() {}); // Update UI when text changes
                          },
                          decoration: InputDecoration(
                            hintText: 'Type your message here...',
                            labelText: 'Message',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton.icon(
                        onPressed: _messageController.text.isNotEmpty
                            ? () {
                                print(_messageController.text);
                                print(_managePostsClicked);
                                print(_manageUsersClicked);
                                print(_manageSettingsClicked);
                                print(_selectedCommunity!["name"]);
                                //TODO: send invitation api by sending these parameters
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Invitation sent!'),
                                  ),
                                );
                              }
                            : null,
                        icon: Icon(Icons.send),
                        label: Text('Send'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            return _messageController.text.isNotEmpty
                                ? Colors.blue
                                : Colors.grey;
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      );
    },
  );
}
