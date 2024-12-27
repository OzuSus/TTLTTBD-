import 'dart:io';
import 'dart:typed_data';

import 'package:ecommerce_app/app/modules/categories/controllers/categories_controller.dart';
import 'package:ecommerce_app/app/modules/category_manage/controllers/category_manage_controller.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CategoryManageView extends GetView<CategoryManageView> {
  const CategoryManageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryManageController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFECEFF1), Color(0xFF31C6FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.deepPurpleAccent),
                      onPressed: () => Get.offNamed(Routes.MANAGE),
                    ),
                    const Expanded(
                      child: Text(
                        'CATEGORY MANAGE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (controller.categories.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: controller.categories.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.categories.length) {
                        return GestureDetector(
                          onTap: () {
                            _showAddCategoryDialog(context, controller);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[100],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blueGrey),
                            ),
                            child: const Center(
                              child: Icon(Icons.add, size: 30, color: Colors.blueGrey),
                            ),
                          ),
                        );
                      }
                      final category = controller.categories[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                category['image'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                category['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_ios,
                                  color: Colors.blueGrey),
                              onPressed: () {
                                _showUpdateCategoryDialog(
                                    context, controller, index);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, CategoryManageController controller) {
    controller.selectedImagePath.value = '';
    controller.selectedImageFile = null;

    final nameController = TextEditingController();

    Get.defaultDialog(
      title: "Add Category",
      titleStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
      content: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => controller.pickImage(),
                child: Obx(() {
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade400, width: 1.5),
                    ),
                    child: controller.selectedImagePath.value.isEmpty
                        ? const Center(
                      child: Text(
                        "Tap to select an image",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    )
                        : Text(
                      "Selected file: ${controller.selectedImagePath.value}",
                      style: const TextStyle(color: Colors.blueAccent, fontSize: 14),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Category Name",
                  labelStyle: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      controller.selectedImageFile != null) {
                    controller.addCategory(nameController.text);
                  } else {
                    Get.snackbar('Lỗi', 'Chưa nhập name và chọn ảnh');
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  "Add Category",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _showUpdateCategoryDialog(BuildContext context, CategoryManageController controller, int index) {
    final nameController = TextEditingController(text: controller.categories[index]['name']);
    final categoryId = controller.categories[index]['id'];

    Get.defaultDialog(
      title: "Update Category",
      titleStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () => controller.pickImageUpdate(categoryId),
              child: Obx(() {
                final imagePath = controller.selectedImagePath.value.isEmpty
                    ? controller.categories[index]['image']
                    : controller.selectedImagePath.value;

                return Container(
                  height: 275,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  ),
                  child: imagePath.isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 100,
                    ),
                  )
                      : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined,
                          size: 50, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        "Tap to select image",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Category Name",
                labelStyle: const TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final newName = nameController.text.trim();
                try {
                  final response = await http.put(
                    Uri.parse('http://localhost:8080/api/categories/updateNameCategory/$categoryId'),
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: {'name': newName},
                  );
                  if (response.statusCode == 200) {
                    if (Get.isDialogOpen == true) {
                      Get.back();
                    }
                    Get.snackbar('Thành công', 'Cập nhập category thành công');

                    Get.back();
                    controller.fetchCategories();
                    final categoryController = Get.find<CategoryController>();
                    categoryController.onInit();
                  } else {
                    Get.snackbar('Lỗi', 'ko thể cập nhập name category');
                  }
                } catch (e) {
                  print("Error occurred: $e");
                  Get.snackbar('Error', 'An error occurred: $e');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: const Text(
                "Update Category",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

