import 'dart:convert';

import 'package:ecommerce_app/app/models/product.dart';
import 'package:ecommerce_app/app/models/user.dart';
import 'package:ecommerce_app/utils/UserUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/dummy_helper.dart';
import '../../../components/custom_snackbar.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  List<Product> products = [];
  var total = 0.0;
  String selectedPaymentMethod = 'COD';
  User? user;

  @override
  void onInit() {
    super.onInit();
    fetchCartProducts();
    fetchUser();
  }

  Future<void> fetchCartProducts() async {
    try {
      final int userId = await UserUtils.getUserId();
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/cart-details/user-products?idUser=$userId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        products = data.map((e) {
          final product = Product.fromJson(e);
          return product;
        }).toList();
        update();
        calculateTotal();
      } else {
        throw Exception('Ko thể load giỏ hàng');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
  Future<void> fetchUser() async {
    try {
      final int userId = await UserUtils.getUserId();
      final response = await http.get(Uri.parse('http://localhost:8080/api/users/id?id=$userId'),);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        user = User.fromJson(data);
        update();
      } else {
        throw Exception('Không thể tải thông tin người dùng');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void calculateTotal() {
    total = products.fold(
      0.0,
          (previousValue, element) => previousValue + (element.price * element.quantity),
    );
    update(['TotalPrice']);
  }

  void onIncreasePressed(int productId) async {
    try {
      final int userId = await UserUtils.getUserId();
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/cart-details/increase-quantity?idUser=$userId&idProduct=$productId'),
      );

      if (response.statusCode == 200) {
        final index = products.indexWhere((p) => p.id == productId);
        if (index != -1) {
          products[index] = products[index].copyWith(quantity: products[index].quantity + 1);
          calculateTotal();
          update(['ProductQuantity']);
        }
      } else {
        throw Exception('Không thể tăng số lượng sản phẩm.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void onDecreasePressed(int productId, BuildContext context, Function showDeleteDialog) async {
    final index = products.indexWhere((p) => p.id == productId);

    if (index != -1 && products[index].quantity == 1) {
      // Gọi hàm hiển thị dialog từ CartItem
      showDeleteDialog();
    } else {
      try {
        final int userId = await UserUtils.getUserId();
        final response = await http.post(
          Uri.parse('http://localhost:8080/api/cart-details/decrease-quantity'),
          body: {'idUser': '$userId', 'idProduct': '$productId'},
        );

        if (response.statusCode == 200) {
          if (index != -1) {
            products[index] = products[index].copyWith(quantity: products[index].quantity - 1);
            calculateTotal();
            update(['ProductQuantity']);
          }
        } else {
          throw Exception('Không thể giảm số lượng sản phẩm.');
        }
      } catch (e) {
        Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      }
    }
  }


  Future<void> onDeletePressed(int productId) async {
    final userId = await UserUtils.getUserId();
    final url = Uri.parse('http://localhost:8080/api/cart-details/remove?idUser=$userId&idProduct=$productId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        products.removeWhere((p) => p.id == productId);
        calculateTotal();
        update();
        Get.snackbar('Thành công', 'Thành công xóa sản phẩm khỏi giỏ hàng');
      } else {
        Get.snackbar('Lỗi', 'Ko th xóa sản phẩm khỏi giỏ hàng');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void onPaymentMethodChanged(String method) {
    selectedPaymentMethod = method;
    update(['PaymentMethod']);
  }

  void onPurchaseNowPressed() async {
    try {
      final int userId = await UserUtils.getUserId();
      int idPaymentMethod;
      switch (selectedPaymentMethod) {
        case 'COD':
          idPaymentMethod = 1;
          break;
        case 'Banking':
          idPaymentMethod = 2;
          break;
        case 'QRCode':
          idPaymentMethod = 3;
          break;
        default:
          throw Exception('Phương thức thanh toán không hợp lệ');
      }
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/orders/place?idUser=$userId&idPaymentMethop=$idPaymentMethod'),
      );
      if (response.statusCode == 200) {
        products.clear();
        calculateTotal();
        update();
        CustomSnackBar.showCustomSnackBar(
          title: 'Mua hàng',
          message: 'Đặt hàng thành công',
        );
        Get.find<BaseController>().changeScreen(0);
      } else {
        throw Exception('Không thể đặt đơn hàng.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}

