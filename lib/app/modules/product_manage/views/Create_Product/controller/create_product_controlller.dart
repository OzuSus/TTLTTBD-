import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommerce_app/app/models/category.dart';
import 'package:ecommerce_app/app/modules/home/controllers/home_controller.dart';
import 'package:ecommerce_app/app/modules/product_manage/controller/product_manage_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/app/models/product.dart';


class CreateProductController extends GetxController{
  var categories = <Category>[].obs;
  final isLoading = true.obs;
  var selectedImagePath = ''.obs;
  Uint8List? selectedImageFile;

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

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        selectedImagePath.value = result.files.single.name;
        selectedImageFile = result.files.single.bytes;
      } else {
        Get.snackbar('Error', 'No image selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }


  Future<void> createProduct(String name,String price,String des,int quantity,String idCategory ) async {
    if (selectedImageFile == null) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }
    String _quantity = quantity.toString();

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:8080/api/products/createProduct'),
      );
      request.fields['name'] = name;
      request.fields['quantity'] = _quantity;
      request.fields['prize'] = price;
      request.fields['description'] = des;
      request.fields['id_category'] = idCategory;


      // Thêm file bằng bytes
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          selectedImageFile!,
          filename: selectedImagePath.value,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        final newProduct = Product.fromJson(jsonData);

        final productManageController = Get.find<ProductManageController>();
        productManageController.products.add(newProduct);
        final homeController = Get.find<HomeController>();
        homeController.onInit();
        selectedImagePath.value = '';
        selectedImageFile = null;
        Get.back();
      } else {
        Get.snackbar('Error', 'Failed to add category');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}