import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';

Comment C = Comment(
    commentId: 0,
    userId: "hafagab",
    postId: "bzjnnjamz",
    username: "rehab/u",
    profilePic: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    votesCount: 5,
    date: DateTime(2024, 3, 1),
    content:
        "Rehab is an extraordinary individual whose presence radiates warmth and inspiration. With her boundless energy and unwavering determination, she navigates through life's challenges with grace and resilience. Her passion for learning and creativity knows no bounds, as she constantly seeks to broaden her horizons and make a positive impact on the world around her. Farida's kindness and compassion touch the hearts of everyone she meets, leaving a lasting impression that transcends time and space. She truly embodies the essence of greatness, and her journey serves as a beacon of hope and inspiration for us all.");

List<Comment> commentsList = [C, C, C, C, C];

List<Comment> getPostComments(int postId) {
  return commentsList; //TODO: Actual fetching logic
}
