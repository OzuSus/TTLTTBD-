import 'dart:convert';

import 'package:ecommerce_app/app/models/product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductManageController extends GetxController{
  var products = <Product>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }
  // @override
  // void onReady() {
  //   super.onReady();
  //   ever(products, (_) => fetchProducts());
  // }

  void fetchProducts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://localhost:8080/api/products'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        products.value = data.map((json) => Product.fromJson(json)).toList();
        products.refresh();
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteProduct(int idProduct) async {
    final url = Uri.parse('http://localhost:8080/api/products/deleteProduct?idProduct=$idProduct');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        products.removeWhere((product) => product.id == idProduct);
        Get.snackbar('Thành công', response.toString(), snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Lỗi', response.toString(), snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi khi xóa sản phẩm', snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }
  void handleUpdatedProduct(Product updatedProduct) {
    final index = products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      products[index] = updatedProduct;
      products.refresh();
    }
  }

}