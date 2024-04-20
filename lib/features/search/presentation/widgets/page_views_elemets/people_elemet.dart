import 'package:flutter/material.dart';

class PeopleElement extends StatefulWidget {

  final String username;
  final String userIcon;

  const PeopleElement({
    required this.username,
    required this.userIcon,
  });

  @override
  State<PeopleElement> createState() => _PeopleElementState();
}

class _PeopleElementState extends State<PeopleElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          Row(
            children:[
              InkWell(
                onTap: () {} , // navigate to user profile
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(widget.userIcon),
                        radius: 17,
                      ),
                    ),
                    Text(
                      widget.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(), 
              Container(
                margin: EdgeInsets.only(left: 7),
                child: ElevatedButton(
                  onPressed: () {},   // follow user
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                    backgroundColor: Colors.blue[900],
                    fixedSize: Size(15,7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ), 
                  ), 
                  child: Text(
                    'Follow',
                    style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
                  ),
                ),
              ), 
            ],
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),      
        ],
      ),
    );
  }
}