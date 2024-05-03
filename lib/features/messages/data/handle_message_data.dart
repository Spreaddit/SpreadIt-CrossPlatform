// import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';
// import 'package:spreadit_crossplatform/user_info.dart';

// enum MessageTypes {
//   inbox,
// }

// /// and fetches its respective [Post] List
// Future<List<Message>> getMessages({
//   required PostCategories category,
//   String? subspreaditName,
//   String? timeSort = "",
//   String? username = "",
// }) async {
//   try {
//     String? accessToken = UserSingleton().getAccessToken();

//     String requestURL = apiUrl +
//         postCategoryEndpoint(
//           action: category,
//           subspreaditName: subspreaditName,
//           timeSort: timeSort,
//           username: username,
//         );
//     final response = await Dio().get(
//       requestURL,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//         },
//       ),
//     );
//     if (response.statusCode == 200) {
//       List<Post> posts =
//           (response.data as List).map((x) => Post.fromJson(x)).toList();
//       return (posts);
//     } else if (response.statusCode == 409) {
//       print("Conflict: ${response.statusMessage}");
//     } else if (response.statusCode == 400) {
//       print("Bad request: ${response.statusMessage}");
//     } else {
//       print("Internal Server Error: ${response.statusCode}");
//     }
//     return [];
//   } on DioException catch (e) {
//     if (e.response != null) {
//       if (e.response!.statusCode == 400) {
//         print("Bad request: ${e.response!.statusMessage}");
//       } else if (e.response!.statusCode == 409) {
//         print("Conflict: ${e.response!.statusMessage}");
//       } else {
//         print("Internal Server Error: ${e.response!.statusMessage}");
//       }
//       return [];
//     }
//     rethrow;
//   } catch (e) {
//     //TO DO: show error message to user
//     print("Error occurred: $e");
//     return [];
//   }
// }

// // /// Takes [PostCategories] as a paremeter
// // /// and fetches its respective [Post] List
// // Future<Post?> getPostById({
// //   required String postId,
// // }) async {
// //   try {
// //     String? accessToken = UserSingleton().getAccessToken();

// //     String requestURL = "$apiUrl/posts/$postId/";

// //     final response = await Dio().get(
// //       requestURL,
// //       options: Options(
// //         headers: {
// //           'Authorization': 'Bearer $accessToken',
// //         },
// //       ),
// //     );
// //     if (response.statusCode == 200) {
// //       return Post.fromJson(response.data);
// //     } else if (response.statusCode == 409) {
// //       print("Conflict: ${response.statusMessage}");
// //     } else if (response.statusCode == 400) {
// //       print("Bad request: ${response.statusMessage}");
// //     } else {
// //       print("Internal Server Error: ${response.statusCode}");
// //     }
// //     return null;
// //   } on DioException catch (e) {
// //     if (e.response != null) {
// //       if (e.response!.statusCode == 400) {
// //         print("Bad request: ${e.response!.statusMessage}");
// //       } else if (e.response!.statusCode == 409) {
// //         print("Conflict: ${e.response!.statusMessage}");
// //       } else {
// //         print("Internal Server Error: ${e.response!.statusMessage}");
// //       }
// //       return null;
// //     }
// //     rethrow;
// //   } catch (e) {
// //     //TO DO: show error message to user
// //     print("Error occurred: $e");
// //     return null;
// //   }
// // }
