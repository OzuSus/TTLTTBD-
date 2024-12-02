import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  // STORING KEYS
  static const String _fcmTokenKey = 'fcm_token';
  static const String _lightThemeKey = 'is_theme_light';
  static const String _userInfoKey = 'user_info';

  /// init get storage services
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static setStorage(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
  }

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) =>
      _sharedPreferences.setBool(_lightThemeKey, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() =>
      _sharedPreferences.getBool(_lightThemeKey) ?? true; // todo set the default theme (true for light, false for dark)

  /// save generated fcm token
  static Future<void> setFcmToken(String token) =>
      _sharedPreferences.setString(_fcmTokenKey, token);

  /// get generated fcm token
  static String? getFcmToken() =>
      _sharedPreferences.getString(_fcmTokenKey);

  /// save user info as JSON string
  static Future<void> setUserInfo(Map<String, dynamic> userInfo) async {
    String userInfoJson = json.encode(userInfo);
    await _sharedPreferences.setString(_userInfoKey, userInfoJson);
  }

  /// get user info as Map
  static Map<String, dynamic>? getUserInfo() {
    String? userInfoJson = _sharedPreferences.getString(_userInfoKey);
    if (userInfoJson != null) {
      return json.decode(userInfoJson) as Map<String, dynamic>;
    }
    return null;
  }
  /// clear all data from shared pref
  static Future<void> clear() async => await _sharedPreferences.clear();

}