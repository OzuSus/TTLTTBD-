import 'dart:convert';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../models/user.dart';

class SettingsController extends GetxController {
  var isLightTheme = MySharedPref.getThemeIsLight();
  Map<String, dynamic>? currentUser;

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  void loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfoString = prefs.getString('user_info');
    if (userInfoString != null) {
      currentUser = json.decode(userInfoString);
      update(['User']);
    }
  }

  void logout() async {
    await MySharedPref.clear();
    currentUser = null;
    update(['User']);
    Get.offAllNamed('/login');
  }

  void changeTheme(bool value) {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }

  void navigateToManage () async {
    Get.toNamed('/manage');
  }
}