import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommunityElement extends StatefulWidget {

  final String communityName;
  final String communityDescription;
  final String communityIcon;
  final String membersCount;
  final bool isFollowing;

  const CommunityElement({
    required this.communityName,
    required this.communityDescription,
    required this.communityIcon,
    required this.membersCount,
    required this.isFollowing,
  });

  @override
  State<CommunityElement> createState() => _CommunityElementState();
}

class _CommunityElementState extends State<CommunityElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {} , // navigate to community
                child: Wrap(
                  children:[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.communityIcon),
                        radius: 17,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.communityName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${widget.membersCount} members',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),                          
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 130, 
                          child: Text(
                            widget.communityDescription,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if(!widget.isFollowing)
                Container(
                  margin: EdgeInsets.only(left: 7),
                  child: ElevatedButton(
                    onPressed: () {},   // join the community
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                      backgroundColor: Colors.blue[900],
                      fixedSize: Size(15,7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ), 
                    ), 
                    child: Text(
                      'Join',
                      style: TextStyle(
                        fontSize: 12,
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