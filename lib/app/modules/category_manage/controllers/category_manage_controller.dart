import 'dart:typed_data';  // Import thêm thư viện dart:typed_data để sử dụng Uint8List
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
            'name': item['name'],
            'image': 'http://localhost:8080/uploads/${item['image']}'
          };
        }).toList();
      } else {
        Get.snackbar('Error', 'Failed to load categories');
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
        Get.snackbar('Error', 'No image selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }


  Future<void> addCategory(String name) async {
    if (selectedImageFile == null) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://localhost:8080/api/categories/add'),
      );
      request.fields['name'] = name;

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
        categories.add({'name': name, 'image': selectedImagePath.value});
        selectedImagePath.value = '';
        selectedImageFile = null;
        Get.back();
        fetchCategories();
      } else {
        Get.snackbar('Error', 'Failed to add category');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void updateCategory(int index, String newName, String newImagePath) {
    categories[index] = {'name': newName, 'image': newImagePath};
  }
}
