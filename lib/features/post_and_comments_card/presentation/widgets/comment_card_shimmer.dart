import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommentCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Comment header with user avatar and name
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              // User avatar
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(width: 8.0),
              // User name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 16.0,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 12.0,
                        width: 100.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Comment content
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 80.0,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        ),
        // Comment interaction buttons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Comment votes
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 24.0,
                  width: 40.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.0),
              // Comment reply button
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: 24.0,
                  width: 80.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
