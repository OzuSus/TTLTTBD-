import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/app/models/product.dart';


class EditProductController extends GetxController{
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
        throw Exception('Failed to load product');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}