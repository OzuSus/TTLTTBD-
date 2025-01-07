import 'dart:typed_data';
import 'package:ecommerce_app/app/models/category.dart';
import 'package:ecommerce_app/app/modules/categories/controllers/categories_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryManageController extends GetxController {
  var categories = <Map<String, dynamic>>[].obs;
  var selectedImagePath = ''.obs;
  Uint8List? selectedImageFile;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/api/categories'));
      if (response.statusCode == 200) {
        final List<dynamic> categoryData = json.decode(response.body);
        categories.value = categoryData.map((item) {
          return {
            'id': item['id'],
            'name': item['name'],
            'image': 'http://localhost:8080/uploads/${item['image']}'
          };
        }).toList();
      } else {
        Get.snackbar('Lỗi', 'Ko thể load category');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
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
        Get.snackbar('Lỗi', 'Chưa chọn ảnh');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
  Future<void> pickImageUpdate(int categoryId) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null) {
        selectedImagePath.value = result.files.single.name;
        selectedImageFile = result.files.single.bytes;
        if (selectedImageFile != null) {
          final request = http.MultipartRequest(
            'PUT',
            Uri.parse('http://localhost:8080/api/categories/updateImageCategory/$categoryId'),
          );
          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              selectedImageFile!,
              filename: selectedImagePath.value,
            ),
          );
          final response = await request.send();
          if (response.statusCode == 200) {
            Get.snackbar('Thành công', 'Hoàn tất cập nhập ảnh');
            final responseBody = await response.stream.bytesToString();
            final responseJson = json.decode(responseBody);
            final imageUrl = 'http://localhost:8080/uploads/${responseJson['image']}';
            selectedImagePath.value = imageUrl;
            fetchCategories();
          } else {
            Get.snackbar('Lỗi', 'Ko thể cập nhập ảnh');
          }
        }
      } else {
        Get.snackbar('Lỗi', 'Chưa chọn ảnh');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  Future<void> addCategory(String name) async {
    if (selectedImageFile == null) {
      Get.snackbar('Lỗi', 'Chưa chọn ảnh');
      return;
    }

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:8080/api/categories/add'),
      );
      request.fields['name'] = name;
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          selectedImageFile!,
          filename: selectedImagePath.value,
        ),
      );
      final response = await request.send();
      if (response.statusCode == 200) {
        categories.add({'name': name, 'image': selectedImagePath.value});
        selectedImagePath.value = '';
        selectedImageFile = null;
        final responseBody = await response.stream.bytesToString();
        final jsonData = json.decode(responseBody);
        final newCategory = Category.fromJson(jsonData);
        final categoryController = Get.find<CategoryController>();
        categoryController.categories.add(newCategory);
        Get.back();
        fetchCategories();
      } else {
        Get.snackbar('Error', 'Failed to add category');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

}
