import 'dart:convert';

import 'package:ecommerce_app/app/models/product.dart';
import 'package:ecommerce_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:ecommerce_app/utils/UserUtils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductDetailsController extends GetxController {
  late Product product;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    final int productId = Get.arguments['id'];
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/products/id?id=$productId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        product = Product.fromJson(data);
      } else {
        throw Exception('Lỗi ko thể fetch product');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addToCart() async {
    try {
      final int userId = await UserUtils.getUserId();
      final response = await http.post(
        Uri.parse(
            'http://localhost:8080/api/cart-details/add?idProduct=${product.id}&idUser=$userId'),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Thành công', 'Thành công thêm sản phẩm vào giỏ hàng!',
            snackPosition: SnackPosition.BOTTOM);
        final cartController = Get.find<CartController>();
        cartController.onInit();
      } else {
        throw Exception('Lỗi ko thể thêm sản phẩm vào giỏ hàng');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

}
