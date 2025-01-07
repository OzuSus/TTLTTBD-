import 'dart:convert';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../models/user.dart';
import '../../purchase_history/views/purchase_history_view.dart';


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
  void navigateToPurchaseHistory () async {
    // Pass the mock purchase history data or fetch it from an API
    List<Purchase> mockPurchaseHistory = [
      Purchase(
        id: '001',
        date: '2025-01-05',
        totalAmount: '150.00',
        status: 'Delivered',
        items: [
          {"name": "Áo thun", "quantity": 1, "price": "150.00"}
        ],
      ),
      Purchase(
        id: '002',
        date: '2025-01-06',
        totalAmount: '50.00',
        status: 'Pending',
        items: [
          {"name": "Quần jean", "quantity": 2, "price": "25.00"}
        ],
      ),
    ];

    // Navigate to the PurchaseHistoryView and pass the purchase history
    Get.to(() => PurchaseHistoryView(purchases: mockPurchaseHistory));
  }

}