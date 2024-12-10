import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../data/models/product_model.dart';
import 'package:http/http.dart' as http;

class FavoritesController extends GetxController {
  final _favoriteProducts = <int>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    try {
      final userId = await _getUserId();
      final String apiUrl = "http://localhost:8080/api/favorites/user/$userId";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _favoriteProducts.value = data.map<int>((item) => item['id'] as int).toSet();
        update(['FavoriteButton']); // Cập nhật trạng thái giao diện
      } else {
        Get.snackbar("Lỗi", "Không thể tải danh sách yêu thích.");
      }
    } catch (e) {
      Get.snackbar("Lỗi", "Có lỗi xảy ra khi tải danh sách yêu thích.");
    }
  }

   Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.getString('user_info');
    if (userInfo != null) {
      final Map<String, dynamic> userMap = json.decode(userInfo);
      return userMap['id'];
    }
    throw Exception("User not logged in");
  }

  bool isFavorite(int productId) {
    return _favoriteProducts.contains(productId);
  }

  Future<void> addFavorite(int userId, int productId) async {
    final String apiUrl = "http://localhost:8080/api/favorites/add?userId=$userId&productId=$productId";
    try {
      final response = await http.post(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        _favoriteProducts.add(productId);
        update(['FavoriteButton']);
        Get.snackbar("Thành công", "Sản phẩm đã được thêm vào danh sách yêu thích.");
      } else {
        Get.snackbar("Lỗi", "Không thể thêm sản phẩm vào danh sách yêu thích.");
      }
    } catch (e) {
      Get.snackbar("Lỗi", "Có lỗi xảy ra khi thêm sản phẩm vào danh sách yêu thích.");
    }
  }

  Future<void> removeFavorite(int userId, int productId) async {
    final String apiUrl = "http://localhost:8080/api/favorites/delete?userId=$userId&productId=$productId";
    try {
      final response = await http.delete(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        _favoriteProducts.remove(productId);
        update(['FavoriteButton']);
        Get.snackbar("Thành công", "Sản phẩm đã được xóa khỏi danh sách yêu thích.");
      } else {
        Get.snackbar("Lỗi", "Không thể xóa sản phẩm khỏi danh sách yêu thích.");
      }
    } catch (e) {
      Get.snackbar("Lỗi", "Có lỗi xảy ra khi xóa sản phẩm khỏi danh sách yêu thích.");
    }
  }
}
