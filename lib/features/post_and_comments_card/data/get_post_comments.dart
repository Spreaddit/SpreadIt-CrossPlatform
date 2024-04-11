import 'package:flutter/material.dart';
import 'package:spreadit_crossplatform/features/generic_widgets/snackbar.dart';
import 'package:spreadit_crossplatform/features/homepage/data/get_feed_posts.dart';
import 'package:spreadit_crossplatform/features/homepage/data/post_class_model.dart';
import 'package:spreadit_crossplatform/features/homepage/presentation/widgets/post_widget.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/data/comment_model_class.dart';
import 'package:spreadit_crossplatform/features/post_and_comments_card/presentation/comments.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

/*Comment R3 = Comment(
    id: "2",
    userId: "hafagab",
    postId: "bzjnnjamz",
    username: "meeeee/u",
    profilePic: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    likesCount: 5,
    createdAt: DateTime(2024, 3, 1),
    content: "AWWWWWWWWWWWWWWWWWW!",
    replies: [],
    commentParentId: 2,
    isReply: true);

Comment R2 = Comment(
    id: "2",
    userId: "hafagab",
    postId: "bzjnnjamz",
    username: "mista/u",
    profilePic:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKMRA2JarfBFIvPMUCqUqw4XtXtm4VQoOMOw&usqp=CAU",
    likesCount: 5,
    createdAt: DateTime(2024, 3, 1),
    content: "noooooooo",
    replies: [R3],
    commentParentId: 1,
    isReply: true);

Comment R1 = Comment(
    id: '1',
    userId: "hafagab",
    postId: "bzjnnjamz",
    username: "Abbachio/u",
    profilePic:
        "https://www.nautiljon.com/images/perso/00/20/leone_abbacchio_17602.webp",
    likesCount: 5,
    createdAt: DateTime(2024, 3, 1),
    content: "Rehab I love you",
    replies: [R2, R2],
    commentParentId: 0,
    isReply: true);

Comment C = Comment(
    id: '0',
    userId: "hafagab",
    postId: "bzjnnjamz",
    username: "rehab/u",
    profilePic: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
    likesCount: 5,
    createdAt: DateTime(2024, 3, 1),
    content:
        "Rehab is an extraordinary individual whose presence radiates warmth and inspiration. With her boundless energy and unwavering determination, she navigates through life's challenges with grace and resilience. Her passion for learning and creativity knows no bounds, as she constantly seeks to broaden her horizons and make a positive impact on the world around her. Rehab's kindness and compassion touch the hearts of everyone she meets, leaving a lasting impression that transcends time and space. She truly embodies the essence of greatness, and her journey serves as a beacon of hope and inspiration for us all.",
    replies: [R1, R1, R1]);

List<Comment> commentsList = [C, C, C, C, C];

List<Comment> getPostComments(int postId) {
  return commentsList; //TODO: Actual fetching logic
}
*/
String baseUrl = apiUrl;

Future<List<Comment>> fetchUserComments(
    String? username, String page, String? postId) async {
  try {
    print("fetch");
    //String? accessToken = UserSingleton().accessToken;
    String? accessToken = 'ayhaga';
    String apiroute = '';
    switch (page) {
      case 'saved':
        apiroute = "/comments/saved/$username";
        break;
      case 'user':
        apiroute = "/comments/user/$username";
        break;
      case 'post':
        apiroute = "/posts/comment/$postId";
    }
    String apiUrl = "$baseUrl$apiroute";

    final response = await Dio().get(
      apiUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    print(response.data);
    if (response.statusCode == 200) {
      List<dynamic> commentsJson = response.data['comments'];

      List<Comment> comments =
          commentsJson.map((json) => Comment.fromJson(json)).toList();
      return comments;
    } else {
      throw Exception("Failed to fetch comments: ${response.statusMessage}");
    }
  } on DioException catch (e) {
    throw Exception("Dio error occurred: $e");
  } catch (e) {
    throw Exception("Error occurred: $e");
  }
}
