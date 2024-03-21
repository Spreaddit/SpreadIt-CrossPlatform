import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post.dart';

class PostFeed extends HookWidget {
  List<Object> items = [x, y, z];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 0,
      ),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return PostWidget(
              postId: 22,
              username: "Ahmed/m",
              userId: "12kwds",
              date: DateTime(2024, 3, 20, 21, 56),
              headline: "Farida is Amazing",
              //imageUrl: "https://static.vecteezy.com/system/resources/previews/008/385/797/non_2x/reddit-social-media-icon-abstract-logo-design-illustration-free-vector.jpg",
              description:
                  "Farida is an extraordinary individual whose presence radiates warmth and inspiration. With her boundless energy and unwavering determination, she navigates through life's challenges with grace and resilience. Her passion for learning and creativity knows no bounds, as she constantly seeks to broaden her horizons and make a positive impact on the world around her. Farida's kindness and compassion touch the hearts of everyone she meets, leaving a lasting impression that transcends time and space. She truly embodies the essence of greatness, and her journey serves as a beacon of hope and inspiration for us all.",
              votesCount: 3,
              sharesCount: 300,
              commentsCount: 9,
              profilePic:
                  "https://static.vecteezy.com/system/resources/previews/008/385/797/non_2x/reddit-social-media-icon-abstract-logo-design-illustration-free-vector.jpg",
            );
          }),
    );
  }
}

var x = {
  'postId': 1,
  'username': "Ahmed/m",
  'userId': "12kwds",
  'date': DateTime(2024, 3, 20, 21, 56),
  'headline': "Farida is Amazing",
  //imageUrl: "https://static.vecteezy.com/system/resources/previews/008/385/797/non_2x/reddit-social-media-icon-abstract-logo-design-illustration-free-vector.jpg",
  'description':
      "Farida is an extraordinary individual whose presence radiates warmth and inspiration. With her boundless energy and unwavering determination, she navigates through life's challenges with grace and resilience. Her passion for learning and creativity knows no bounds, as she constantly seeks to broaden her horizons and make a positive impact on the world around her. Farida's kindness and compassion touch the hearts of everyone she meets, leaving a lasting impression that transcends time and space. She truly embodies the essence of greatness, and her journey serves as a beacon of hope and inspiration for us all.",
  'votesCount': 3,
  'sharesCount': 300,
  'commentsCount': 9,
  'profilePic':
      "https://static.vecteezy.com/system/resources/previews/008/385/797/non_2x/reddit-social-media-icon-abstract-logo-design-illustration-free-vector.jpg",
};

var y = {
  'postId': 1,
  'username': "Ahmed/m",
  'userId': "12kwds",
  'date': DateTime(2024, 3, 20, 21, 56),
  'headline': "Farida is Amazing",
  //imageUrl: "https://static.vecteezy.com/system/resources/previews/008/385/797/non_2x/reddit-social-media-icon-abstract-logo-design-illustration-free-vector.jpg",
  'description':
      "Farida is an extraordinary individual whose presence radiates warmth and inspiration. With her boundless energy and unwavering determination, she navigates through life's challenges with grace and resilience. Her passion for learning and creativity knows no bounds, as she constantly seeks to broaden her horizons and make a positive impact on the world around her. Farida's kindness and compassion touch the hearts of everyone she meets, leaving a lasting impression that transcends time and space. She truly embodies the essence of greatness, and her journey serves as a beacon of hope and inspiration for us all.",
  'votesCount': 3,
  'sharesCount': 300,
  'commentsCount': 9,
  'profilePic':
      "https://static.vecteezy.com/system/resources/previews/008/385/797/non_2x/reddit-social-media-icon-abstract-logo-design-illustration-free-vector.jpg",
};

var z = {
  'postId': 1,
  'username': "Ahmed/m",
  'userId': "12kwds",
  'date': DateTime(2024, 3, 20, 21, 56),
  'headline': "Farida is Amazing",
  //imageUrl: "https://static.vecteezy.com/system/resources/previews/008/385/797/non_2x/reddit-social-media-icon-abstract-logo-design-illustration-free-vector.jpg",
  'description':
      "Farida is an extraordinary individual whose presence radiates warmth and inspiration. With her boundless energy and unwavering determination, she navigates through life's challenges with grace and resilience. Her passion for learning and creativity knows no bounds, as she constantly seeks to broaden her horizons and make a positive impact on the world around her. Farida's kindness and compassion touch the hearts of everyone she meets, leaving a lasting impression that transcends time and space. She truly embodies the essence of greatness, and her journey serves as a beacon of hope and inspiration for us all.",
  'votesCount': 3,
  'sharesCount': 300,
  'commentsCount': 9,
  'profilePic':
      "https://static.vecteezy.com/system/resources/previews/008/385/797/non_2x/reddit-social-media-icon-abstract-logo-design-illustration-free-vector.jpg",
};
