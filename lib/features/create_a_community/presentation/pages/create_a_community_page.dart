/// This file contains the CreateCommunityPage widget which is a stateful widget.
/// This widget allows the user to create a new community by providing the necessary details.
///
/// The user can specify the community name, type, and whether it is 18+ or not.
///
/// This file also imports necessary packages and widgets required for the CreateCommunityPage widget.

import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/button.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/features/create_a_community/data/data_source/create_a_community_service.dart';

/// The CreateCommunityPage widget is a stateful widget that builds the UI for creating a new community.
class CreateCommunityPage extends StatefulWidget {
  @override

  /// Creates the mutable state for this widget at a given location in the tree.
  State<CreateCommunityPage> createState() => _CreateCommunityPageState();
}

/// The _CreateCommunityPageState class is the logic and internal state for a StatefulWidget.
class _CreateCommunityPageState extends State<CreateCommunityPage> {
  /// A list of community types that the user can choose from.
  final communityType = [
    ' Public \n Anyone can view post, and comment to this  community',
    ' Private \n Only approved members can view and contribute to this community',
    ' Restricted \n Only approved members can view this community',
  ];

  /// The HTTP response status code.
  int? _responseStatus;

  /// The name of the community that the user inputs.
  String _communityName = "";

  /// A controller for an editable text field.
  final _controller = TextEditingController();

  /// The index of the selected community type in the communityType list.
  var selectedCommunityType = 0;

  /// A boolean value that indicates whether the community is 18+ or not.
  bool _is18Plus = false;

  @override

  /// Describes the part of the user interface represented by this widget.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a community'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Community Name',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                _communityName = value;
                setState(() {});
              },
              decoration: InputDecoration(
                filled: true,
                enabledBorder: InputBorder.none,
                fillColor: Colors.grey[200],
                labelText: 'r/Community Name',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: 'CommunityName',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                prefixText: 'r/',
                suffix: Text('${21 - _controller.text.length}'),
              ),
            ),
          ),
          Visibility(
            visible: _responseStatus == 204,
            child: Text(
              'Community Name Already taken!',
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Visibility(
                visible: _responseStatus == 205,
                child: Text(
                  'Must be between 3 and 21 characters long and can only contain letters, numbers, and underscores.',
                ),
              )),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Community type',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              key: Key('communityTypeGestureDetector'),
              onTap: _onCommunityTypePress,
              child: Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            communityType[selectedCommunityType]
                                .split('\n')
                                .first
                                .trim(),
                            key: Key('communityTypeText'),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          ...communityType[selectedCommunityType]
                              .split('\n')
                              .skip(1)
                              .map((line) => Text(
                                    line.trim(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SwitchListTile(
            activeColor: Colors.white,
            activeTrackColor: Color.fromARGB(255, 4, 69, 198),
            title: Text(
              '18+ community',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            value: _is18Plus,
            onChanged: (bool value) {
              setState(() {
                _is18Plus = value;
              });
            },
          ),
          SizedBox(height: 20),
          Button(
            onPressed: _onCreateCommunityPress,
            text: 'Create community',
            backgroundColor: Color.fromARGB(255, 6, 107, 190),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }

  void _onCreateCommunityPress() async {
    if (_communityName.length < 3 ||
        _communityName.length > 21 ||
        !_communityName.contains(RegExp(r'^[a-zA-Z0-9_]*$'))) {
      setState(() {
        _responseStatus = 205;
      });
      return;
    }

    final dio = Dio();
    final client = RestClient(dio);

    final community = Community(_communityName);

    try {
      final response = await client.createCommunity(community);
      setState(() {
        _responseStatus = response.response.statusCode;
      });
      if (response.response.statusCode == 200) {
        // Navigate to the community page
        print('Community created successfully!');
      } else {
        print('oh noooooooo');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _onCommunityTypePress() async {
    List<IconData> icons = [
      Icons.account_circle_outlined,
      Icons.lock_outlined,
      Icons.check_circle_outline,
    ];

    await showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
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
                      leading: Icon(icons[index % icons.length]),
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
