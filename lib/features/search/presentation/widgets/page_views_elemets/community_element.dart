import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spreadit_crossplatform/features/community/data/api_subscription_info.dart';
import 'package:spreadit_crossplatform/features/dynamic_navigations/navigate_to_community.dart';

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

  void joincommunity () async {
    await postSubscribeRequest(postRequestInfo: {'communityName': widget.communityName});
    setState(() {});
  }

  void unjoinCommunity () async {
    await postUnsubscribeRequest(postRequestInfo: {'communityName': widget.communityName});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {navigateToCommunity(context, widget.communityName);} , // navigate to community
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
              Container(
                margin: EdgeInsets.only(left: 7),
                child: ElevatedButton(
                  onPressed: widget.isFollowing ? unjoinCommunity : joincommunity ,  
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.blue[900]!),
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                    backgroundColor: widget.isFollowing? Colors.white : Colors.blue[900],
                    fixedSize: Size(15,7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),         
                  ), 
                  child: Text(
                    widget.isFollowing ? 'Unjoin' :'Join',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color:  widget.isFollowing ? Colors.blue[900] : Colors.white,
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