import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';


FirebaseMessaging messaging = FirebaseMessaging.instance;
//String baseUrl = "Notification/2.0.0";


Future<int> subscribeToNotifications() async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiRoute = '$apiUrl/notifications/subscribe';
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge : true,
      carPlay : false,
      criticalAlert: false,
      provisional: false,
      sound:true,
    );
    String? token = await messaging.getToken();
    print('FCM Token: $token');
    var data = {
      "fcmToken": token,
    };

    final response = await Dio().post(
      apiRoute,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    if (response.statusCode == 200) {
      print("message ${response.data['message']}");
      return 200;
    } else if (response.statusCode == 500) {
      print("Server error: ${response.statusMessage}");
      return 500;
    } 
     else if (response.statusCode == 400) {
      print("Bad request");
      return 400;
    } else {
      print("Unexpected status code: ${response.statusCode}");
      return 404;
    }
  } on DioException catch (e) {
    if (e.response!.statusCode == 500) {
      print("Server error");
      return 500;
    } 
     else if (e.response!.statusCode == 400) {
      print("Bad request");
      return 400;
    }
    rethrow;
  } catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}
