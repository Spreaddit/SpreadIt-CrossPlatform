import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrendingCardMobile extends StatefulWidget {

  final String title;
  final String content;
  final String image;

  const TrendingCardMobile({
    required this.title,
    required this.content,
    required this.image,
  });

  @override
  State<TrendingCardMobile> createState() => _TrendingCardMobileState();
}

class _TrendingCardMobileState extends State<TrendingCardMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Column(
        children: [
          Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 90, 
                      child: Text(
                        widget.content,
                        softWrap: true, 
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 50,
                      width: 100,
                      child: Image(
                        height: 50,
                        width: 100,
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

