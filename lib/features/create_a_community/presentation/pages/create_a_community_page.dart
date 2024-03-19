import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/widgets/generic/button.dart';
import 'package:spreadit_crossplatform/features/widgets/generic/custom_input.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/features/create_a_community/data/data_source/create_a_community_service.dart';

class CreateCommunityPage extends StatefulWidget {
  @override
  State<CreateCommunityPage> createState() => _CreateCommunityPageState();
}

class _CreateCommunityPageState extends State<CreateCommunityPage> {
  final communityType = [
    ' Public \n Anyone can view post, and comment to this  community',
    ' Private \n Only approved members can view and contribute to this community',
    ' Restricted \n Only approved members can view this community',
  ];

  String _communityName = "";

  var selectedCommunityType = 0;

  @override
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CustomInput(
            formKey: GlobalKey<FormState>(),
            onChanged: (value, isValid) {
              _communityName = value;
            },
            label: 'Community Name',
            placeholder: 'r/CommunityName',
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Community type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: _onCommunityTypePress,
              child: Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: communityType[selectedCommunityType]
                            .split('\n')
                            .map((line) => Text(
                                  line,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Button(
            onPressed: _onCreateCommunityPress,
            text: 'Create a community',
            backgroundColor: Color.fromARGB(255, 6, 107, 190),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }

  void _onCreateCommunityPress() async {
    final dio = Dio();
    final client = RestClient(dio);

    final community = Community(_communityName);

    try {
      final response = await client.createCommunity(community);
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
    ]; // Add your desired icons

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
