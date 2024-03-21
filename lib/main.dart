import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/homepage/widgets/post_feed.dart';
import 'package:spreadit_crossplatform/theme/theme.dart';
import 'package:spreadit_crossplatform/features/homepage/widgets/post.dart';

void main() {
  runApp(SpreadIt());
}

class SpreadIt extends StatelessWidget {
  SpreadIt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spread It',
      theme: spreadItTheme,
      home: PostFeed(),
    );
  }
}

final x = {
  'postId': 1,
  'username': "Ahmed/m",
  'userId': "12kwds",
  'date': DateTime(2023),
  'headline': "Farida is Amazing",
  'description':
      "Farida is an extraordinary individual whose presence radiates warmth and inspiration. With her boundless energy and unwavering determination, she navigates through life's challenges with grace and resilience. Her passion for learning and creativity knows no bounds, as she constantly seeks to broaden her horizons and make a positive impact on the world around her. Farida's kindness and compassion touch the hearts of everyone she meets, leaving a lasting impression that transcends time and space. She truly embodies the essence of greatness, and her journey serves as a beacon of hope and inspiration for us all.",
  'votesCount': 3000,
  'sharesCount': 20,
  'commentsCount': 6
};
