import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrendingCardWeb extends StatefulWidget {

  final String image ;
  final String title;
  final String? content;
  final String communityIcon;
  final String communityName;

  const TrendingCardWeb({
    required this.image,
    required this.title,
    this.content,
    required this.communityIcon,
    required this.communityName,
  });

  @override
  State<TrendingCardWeb> createState() => _TrendingCardWebState();
}

class _TrendingCardWebState extends State<TrendingCardWeb> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 350,
              height: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.cover, 
                    ),
                    Container( 
                      color: Colors.black.withOpacity(0.3), 
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: FractionallySizedBox( 
              heightFactor: 0.8, 
              child: Container(
                color: Colors.transparent,
                width: 400, 
                child: Padding(
                  padding: const EdgeInsets.only(left: 5,right:5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if(widget.content != null && widget.content != '')
                      Text(
                        widget.content!,
                        softWrap: true,
                        maxLines: 1, 
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.communityIcon),
                            radius: 10,
                          ),
                          Text(
                            widget.communityName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            ' and more',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}