import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/features/user_interactions/data/api.dart';

enum InteractWithUsersActions { follow, unfollow, block, report }

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

void interactWithUser(
    {required String userId,
    required InteractWithUsersActions action,
    String? reportReason}) async {
  try {
    String requestURL = apiURL() + interactionType(action);
    var data = {'userId': userId, 'reason': reportReason};
    final response = await Dio().post(requestURL, data: data);
    if (response.statusCode == 200) {
      //TO DO: implement logic needed to re-render UI
      print(response.statusMessage);
    } else {
      //TO DO: show error message to user
      print(response.statusCode);
    }
  } catch (e) {
    //TO DO: show error message to user
    print(e);
  }
}
