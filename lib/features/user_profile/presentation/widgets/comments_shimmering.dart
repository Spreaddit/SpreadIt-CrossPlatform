import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';

import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/interaction_button.dart';

class CommentShimmerWidget extends StatelessWidget {
  final bool saved;

  CommentShimmerWidget({required this.saved});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: Duration(milliseconds: 1000),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: 100.0,
                    height: 10.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  if (generateRandomNumber() % 2 == 0)
                    Container(
                      width: double.infinity,
                      height: 200.0,
                      color: Colors.white,
                    ),
                  SizedBox(height: 15.0),
                  if(saved)
                  ShimmeringCommentFooter(),
                ],
              ),
            ),
          );
  }
}

class ShimmeringCommentFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: kIsWeb ? screenHeight * 0.02 : screenWidth * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
              SizedBox(width: screenWidth * 0.01),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.reply, color: Colors.grey),
                    Text(
                      'Reply',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.01),
              UpVoteButton(
                color: Colors.grey,
                width: screenHeight * 0.02,
                height: screenHeight * 0.02,
              ),
              Text('${generateRandomNumber()}'),
              DownVoteButton(
                color: Colors.grey,
                width: screenHeight * 0.02,
                height: screenHeight * 0.02,
              ),
            ],
          ),
        ],
      ),
    );
  }

}

int generateRandomNumber() {
  Random random = Random();
  return random.nextInt(1000) + 1;
}