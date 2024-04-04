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
  }

  User? getUser() {
    return user;
  }

  void setAccessToken(String token, DateTime expiry) {
    accessToken = token;
    accessTokenExpiry = expiry;
  }

  String? getAccessToken() {
    return accessToken;
  }

  DateTime? getAccessTokenExpiry() {
    return accessTokenExpiry;
  }
}
