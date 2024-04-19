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

  void setUser(User newUser) {
    user = newUser;
    _saveToPrefs(); // Save to shared preferences when user is set
  }

  User? getUser() {
    return user;
  }

  void setAccessToken(String token, DateTime expiry) {
    accessToken = token;
    accessTokenExpiry = expiry;
    _saveToPrefs(); // Save to shared preferences when access token is set
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
    
    String jsonString = json.encode({
      'user': user?.toJson(),
      'access_token': accessToken,
      'token_expiration_date': accessTokenExpiry?.toIso8601String(),
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
      accessTokenExpiry = jsonMap['token_expiration_date'] != null
          ? DateTime.parse(jsonMap['token_expiration_date'])
          : null;
    }
  }

    // Clear user information from shared preferences
  Future<void> clearUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userSingleton');
  }
}
