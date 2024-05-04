import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:spreadit_crossplatform/api.dart';
import 'package:spreadit_crossplatform/user_info.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<int> subscribeToNotifications() async {
  try {
    String? accessToken = UserSingleton().accessToken;
    String apiRoute = '$apiUrl/notifications/subscribe';
    
    // Request notification permission
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    
    // Get FCM token
    String? token = await messaging.getToken(
      vapidKey:
          'BDdxkpSfsZfMF7ZyPklut-xQVgp6HH8GkJnTRHXGlsGv6u3oDujnIiqPF9_iqq_POtjU8tLuEISutYyAiyZC7dw',
    );
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
    } else if (response.statusCode == 400) {
      print("Bad request");
      return 400;
    } else {
      print("Unexpected status code: ${response.statusCode}");
      return 404;
    }
  } on FirebaseException catch (e) {
    if (e.code == 'messaging/permission-blocked') {
      print('User blocked notifications.');
      return 200;
    }
    return 404;
  } on DioException catch (e) {
    if (e.response != null) {
      if (e.response!.statusCode == 500) {
        print("Server error");
        return 500;
      } else if (e.response!.statusCode == 400) {
        print("Bad request");
        return 400;
      }
    }
    rethrow;
  }  catch (e) {
    print("Error occurred: $e");
    return 404;
  }
}
