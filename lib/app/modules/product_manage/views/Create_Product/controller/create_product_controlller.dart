import 'dart:convert';

import 'package:ecommerce_app/app/models/category.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/app/models/product.dart';


class CreateProductController extends GetxController{
  var categories = <Category>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://localhost:8080/api/categories'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        categories.value = data.map((json) => Category.fromJson(json)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch categories');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories');
    } finally {
      isLoading(false);
    }
  }
  Future changeAvatar() async {

  }
}