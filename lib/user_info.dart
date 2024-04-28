import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './features/user.dart';


class UserSingleton {
  static final UserSingleton _singleton = UserSingleton._internal();

  factory UserSingleton() {
    return _singleton;
  }

  UserSingleton._internal();

  User? user;
  String? accessToken;
  DateTime? accessTokenExpiry;
  String? googleToken;
  String? googleEmail;
  bool? isloggedIn;

  void setUser(User newUser) {
    user = newUser;
    _saveToPrefs(); 
  }

  void setGoogleInfo(String token , String email) {
    googleEmail=email;
    googleToken=token;
    _saveToPrefs(); 
  }

  User? getUser() {
    return user;
  }

  void setAccessToken(String token, DateTime expiry) {
    accessToken = token;
    accessTokenExpiry = expiry;
    _saveToPrefs(); 
  }

  String? getAccessToken() {
    return accessToken;
  }

  DateTime? getAccessTokenExpiry() {
    return accessTokenExpiry;
  }

  // Save data to shared preferences
  Future<void> _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isloggedIn=true;
    String jsonString = json.encode({
      'user': user?.toJson(),
      'access_token': accessToken,
      'token_expiration_date': accessTokenExpiry?.toIso8601String(),
      'google_token': googleToken,
      'google_email': googleEmail,
      'isLoggedin' : isloggedIn,
    });
    await prefs.setString('userSingleton', jsonString);
  }


  // Load data from shared preferences
  Future<void> loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('userSingleton');
    print(" loading $jsonString");
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      user = jsonMap['user'] != null ? User.fromJson(jsonMap['user']) : null;
      accessToken = jsonMap['access_token'];
      googleToken = jsonMap['google_token'];
      googleEmail = jsonMap['google_email'];
      accessTokenExpiry = jsonMap['token_expiration_date'] != null
          ? DateTime.parse(jsonMap['token_expiration_date'])
          : null;
      isloggedIn = jsonMap['isLoggedin'];

    }
  }
    // Clear user information from shared preferences
  Future<void> clearUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isloggedIn=false;
    await prefs.remove('userSingleton');
  }
}
