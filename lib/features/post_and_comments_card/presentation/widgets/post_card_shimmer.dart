import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                radius: 16.0,
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 12.0,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 8.0,
                        width: 80.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 120.0,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_upward, color: Colors.grey, size: 16.0),
                  SizedBox(width: 4.0),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 16.0,
                      width: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.comment, color: Colors.grey, size: 16.0),
                  SizedBox(width: 4.0),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 16.0,
                      width: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.share, color: Colors.grey, size: 16.0),
                  SizedBox(width: 4.0),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 16.0,
                      width: 40.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
