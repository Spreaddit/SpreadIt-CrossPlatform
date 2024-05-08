import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './features/user.dart';
/// A singleton class responsible for managing user-related data and storing it in shared preferences.
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
  String? firebaseId;
  bool? verifyEmailCalledForSignup;

  /// Sets the Firebase ID for the user and saves it to shared preferences.
  void setUserId(String userId) {
    firebaseId = userId;
    _saveToPrefs();
  }

  /// Sets the flag indicating email verification is called for signup and saves it to shared preferences.
  void setVerify() {
    verifyEmailCalledForSignup = true;
    _saveToPrefs();
  }

  /// Sets the user and saves it to shared preferences.
  void setUser(User newUser) {
    user = newUser;
    _saveToPrefs();
  }

  /// Sets the user as verified and saves it to shared preferences.
  void setVerifed() {
    User newUser = user!;
    newUser.isVerified = true;
    user = newUser;
    _saveToPrefs();
  }

  /// Sets Google information (token and email) and saves it to shared preferences.
  void setGoogleInfo(String token, String email) {
    googleEmail = email;
    googleToken = token;
    _saveToPrefs();
  }

  /// Retrieves the current user.
  User? getUser() {
    return user;
  }

  /// Retrieves the access token.
    void setAccessToken(String token, DateTime expiry) {
    accessToken = token;
    accessTokenExpiry = expiry;
    _saveToPrefs();
  }

  String? getAccessToken() {
    return accessToken;
  }

  /// Retrieves the access token expiry date.
  DateTime? getAccessTokenExpiry() {
    return accessTokenExpiry;
  }

  /// Saves user data to shared preferences.
  Future<void> _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isloggedIn = true;
    String jsonString = json.encode({
      'user': user?.toJson(),
      'access_token': accessToken,
      'token_expiration_date': accessTokenExpiry?.toIso8601String(),
      'google_token': googleToken,
      'google_email': googleEmail,
      'isLoggedin': isloggedIn,
      'firebaseId': firebaseId,
    });
    await prefs.setString('userSingleton', jsonString);
  }

  /// Loads user data from shared preferences.
  Future<void> loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('userSingleton');
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
      firebaseId = jsonMap['firebaseId'];
    }
  }

  /// Clears user data from shared preferences.
  Future<void> clearUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isloggedIn = false;
    verifyEmailCalledForSignup=false;
    await prefs.remove('userSingleton');
  }
}
