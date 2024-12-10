import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserUtils {
  static Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.getString('user_info');
    if (userInfo != null) {
      final Map<String, dynamic> userMap = json.decode(userInfo);
      return userMap['id'];
    }
    throw Exception("User not logged in");
  }
}
