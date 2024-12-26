import 'dart:convert';

import 'package:ecommerce_app/app/models/product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/dummy_helper.dart';
import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
  @override
  void onReady() {
    super.onReady();
    ever(products, (_) => fetchProducts());
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://localhost:8080/api/products'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        products.value = data.map((json) => Product.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }
}