import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../components/screen_title.dart';
import '../controllers/categories_controller.dart';
import 'widgets/category_item.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.categories.isEmpty) {
            return const Center(child: Text('No categories available.'));
          }

          return ListView(
            children: [
              30.verticalSpace,
              const ScreenTitle(
                title: 'Categories',
                dividerEndIndent: 150,
              ),
              10.verticalSpace,
              ListView.builder(
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  return CategoryItem(
                    name: category.name,
                    imageName: category.image, // Tên ảnh từ API
                    id: category.id,
                  ).animate().fade().slideY(
                    duration: const Duration(milliseconds: 300),
                    begin: 1,
                    curve: Curves.easeInSine,
                  );
                },
                shrinkWrap: true,
                primary: false,
              ),
            ],
          );
        }),
      ),
    );
  }
}
