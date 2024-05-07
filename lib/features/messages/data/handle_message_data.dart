import 'dart:math';

import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/features/messages/data/message_model.dart';
import 'package:spreadit_crossplatform/user_info.dart';

/// and fetches its respective [Message] List
Future<List<MessageModel>> getMessages() async {
  try {
    String? accessToken = UserSingleton().getAccessToken();

    String requestURL = '$apiUrl/message/messages';
    final response = await Dio().get(
      requestURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.data);

      String conversationId = "";

      List<MessageModel> messageList = [];

      for (var data in (response.data as List)) {
        if (conversationId == data['conversationId']) {
          messageList[messageList.length - 1].replies!.add(
                MessageRepliesModel.fromJson(
                  data,
                ),
              );
        } else {
          conversationId = data['conversationId'];
          messageList.add(MessageModel.fromJson(data));
        }
      }
      return messageList;
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
    } else {
      print("Internal Server Error: ${response.statusCode}");
    }
    return [];
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
      } else if (e.response!.statusCode == 409) {
        print("Conflict: ${e.response!.statusMessage}");
      } else {
        print("Internal Server Error: ${e.response!.statusMessage}");
      }
      return [];
    }
    rethrow;
  } catch (e) {
    //TO DO: show error message to user
    print("Error occurred: $e");
    return [];
  }
}

Future<MessageModel?> sendMessage({
  required String username,
  required String subject,
  String? messageId,
  String? message = "",
}) async {
  try {
    String? accessToken = UserSingleton().getAccessToken();
    String requestURL = '';
    if (messageId == null) {
      requestURL = '$apiUrl/message/compose/';
    } else {
      requestURL = '$apiUrl/message/reply/$messageId';
    }
    Map<String, dynamic> requestBody = {
      'content': message,
      'username': username,
      'subject': subject,
    };
    if (messageId == null) {}
    final response = await Dio().post(
      requestURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
      data: requestBody,
    );
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 300) {
      print(response.data);
      return MessageModel.fromJson(response.data['messageContent']);
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
    } else {
      print("Internal Server Error: ${response.statusCode}");
    }
    return null;
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
      } else if (e.response!.statusCode == 409) {
        print("Conflict: ${e.response!.statusMessage}");
      } else {
        print("Internal Server Error: ${e.response!.statusMessage}");
      }
    }
    rethrow;
  } catch (e) {
    //TO DO: show error message to user
    print("Error occurred: $e");
    return null;
  }
}

Future<List<MessageModel>> handleReadMessages({
  required bool shouldRead,
  String? messageId,
}) async {
  try {
    String? accessToken = UserSingleton().getAccessToken();
    String requestURL = '';
    if (shouldRead) {
      if (messageId == null) {
        requestURL = '$apiUrl/message/readallmessages/';
      } else {
        requestURL = '$apiUrl/message/readmsg/$messageId';
      }
    } else {
      requestURL = '$apiUrl/message/unreadmsg/$messageId';
    }
    final response = await Dio().post(
      requestURL,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.data);

      String conversationId = "";

      List<MessageModel> messageList = [];

      for (var data in (response.data as List)) {
        if (conversationId == data['conversationId']) {
          messageList[messageList.length - 1].replies!.add(
                MessageRepliesModel.fromJson(
                  data,
                ),
              );
        } else {
          conversationId = data['conversationId'];
          messageList.add(MessageModel.fromJson(data));
        }
      }
      return messageList;
    } else if (response.statusCode == 409) {
      print("Conflict: ${response.statusMessage}");
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
    } else {
      print("Internal Server Error: ${response.statusCode}");
    }
    return [];
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage}");
      } else if (e.response!.statusCode == 409) {
        print("Conflict: ${e.response!.statusMessage}");
      } else {
        print("Internal Server Error: ${e.response!.statusMessage}");
      }
      return [];
    }
    rethrow;
  } catch (e) {
    //TO DO: show error message to user
    print("Error occurred: $e");
    return [];
  }
}

// /// Takes [messageId] as a paremeter
// /// and fetches its respective [Post] List
// Future<Post?> getPostById({
//   required String postId,
// }) async {
//   try {
//     String? accessToken = UserSingleton().getAccessToken();

//     String requestURL = "$apiUrl/posts/$postId/";

//     final response = await Dio().get(
//       requestURL,
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $accessToken',
//         },
//       ),
//     );
//     if (response.statusCode == 200) {
//       return Post.fromJson(response.data);
//     } else if (response.statusCode == 409) {
//       print("Conflict: ${response.statusMessage}");
//     } else if (response.statusCode == 400) {
//       print("Bad request: ${response.statusMessage}");
//     } else {
//       print("Internal Server Error: ${response.statusCode}");
//     }
//     return null;
//   } on DioException catch (e) {
//     if (e.response != null) {
//       if (e.response!.statusCode == 400) {
//         print("Bad request: ${e.response!.statusMessage}");
//       } else if (e.response!.statusCode == 409) {
//         print("Conflict: ${e.response!.statusMessage}");
//       } else {
//         print("Internal Server Error: ${e.response!.statusMessage}");
//       }
//       return null;
//     }
//     rethrow;
//   } catch (e) {
//     //TO DO: show error message to user
//     print("Error occurred: $e");
//     return null;
//   }
// }
