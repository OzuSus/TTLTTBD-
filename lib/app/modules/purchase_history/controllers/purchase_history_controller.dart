import 'dart:convert';

import 'package:ecommerce_app/app/models/order.dart';
import 'package:ecommerce_app/app/models/order_detail.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PurchaseHistoryController extends GetxController {
  var orders = <Order>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrder();
  }

  void fetchOrder() async {
    final int userId = Get.arguments['id'];
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://localhost:8080/api/orders/user/$userId'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        orders.value = data.map((json) => Order.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
      print('Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }


}
