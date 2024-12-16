import 'dart:convert';

import 'package:ecommerce_app/app/models/category.dart';
import 'package:ecommerce_app/app/models/product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductTypesController extends GetxController{
  var products = <Product>[].obs;
  var isLoading = true.obs;


  @override
  void onInit() {
    super.onInit();
    fetchProducts();

  }
  //aaaa
  //dfdsf

  void fetchProducts() async {
    final int categoryId = Get.arguments['idCategory'];
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://localhost:8080/api/products/idCategory?idCategory=$categoryId'));

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