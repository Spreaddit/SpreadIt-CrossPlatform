import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrendingCardMobile extends StatefulWidget {

  final String title;
  final String content;
  final String? image;
  final String? video;

  const TrendingCardMobile({
    required this.title,
    required this.content,
    this.image,
    this.video,
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
                if (widget.image != null && (widget.image!.isNotEmpty || widget.image != '') )...[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                          height: 50,
                          width: 100,
                          child: Image(
                            height: 50,
                            width: 100,
                            image: AssetImage(widget.image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                if (widget.video != null && (widget.video!.isNotEmpty || widget.video != '') )...[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: SizedBox(
                              height: 50,
                              width: 100,
                              child: Image(
                                height: 50,
                                width: 100,
                                image: AssetImage(widget.video!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5.0, 
                            left: 5.0, 
                            child: Icon(
                              Icons.play_circle_fill_rounded, 
                              size: 17, 
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
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

