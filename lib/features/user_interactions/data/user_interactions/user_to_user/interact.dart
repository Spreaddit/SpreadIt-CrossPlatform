import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

///describes different user_to_user interactions
enum InteractWithUsersActions { follow, unfollow, block, report }

/// takes [InteractWithUsersActions] as a parameter and
/// returns its respective endpoint
String interactionType(InteractWithUsersActions action) {
  switch (action) {
    case InteractWithUsersActions.follow:
      return "/users/follow/";
    case InteractWithUsersActions.unfollow:
      return "/users/unfollow/";
    case InteractWithUsersActions.block:
      return "/users/block/";
    case InteractWithUsersActions.report:
      return "/users/report/";
  }
}

/// Takes the following parameters:
/// - [InteractWithUsersActions] (representing a user_to_user interaction)
/// - [userId] (represnting the user with which the logged in user interacted)
/// and sends a post request to its respective endpoint
/// to update the user_to_user interactions
void interactWithUser(
    {required String userId,
    required InteractWithUsersActions action,
    String? reportReason}) async {
  try {
    String requestURL = apiUrl + interactionType(action);
    String accessToken = UserSingleton().accessToken!;
    var data = {
      'username': userId,
      'reason': reportReason,
    };
    final response = await Dio().post(
      requestURL,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    if (response.statusCode == 200) {
      //TO DO: implement logic needed to re-render UI
      print(response.statusMessage);
    } else if (response.statusCode == 404) {
      print("Not Found: ${response.statusMessage}");
    } else if (response.statusCode == 400) {
      print("Bad request: ${response.statusMessage}");
    } else {
      print("Internal Server Error: ${response.statusCode}");
    }
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 400) {
        print("Bad request: ${e.response!.statusMessage} ${e.message}");
      } else if (e.response!.statusCode == 404) {
        print("Not Found: ${e.response!.statusMessage}");
      } else {
        print("Internal Server Error: ${e.response!.statusMessage}");
      }
    }
    rethrow;
  } catch (e) {
    //TO DO: show error message to user
    print("Error occurred: $e");
  }
}
