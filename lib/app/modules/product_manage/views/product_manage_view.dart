import 'package:ecommerce_app/app/components/screen_title.dart';
import 'package:ecommerce_app/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:ecommerce_app/app/modules/product_manage/controller/product_manage_controller.dart';
import 'package:ecommerce_app/app/modules/product_manage/views/widgets/product_item.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProductManageView extends GetView<ProductManageController> {
  const ProductManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Áp dụng màu nền dạng gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEDEBBE), // Màu vàng nhạt
              Color(0xFFCAF4B7), // Màu xanh lá nhạt
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.products.isEmpty) {
                return const Center(child: Text('No products available'));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thanh tiêu đề với nút quay lại và tạo sản phẩm
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Get.offNamed(Routes.MANAGE),
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                            iconSize: 28.0,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Product Manage',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Get.toNamed(Routes.PRODUCT_CREATE);
                        },
                        icon: const Icon(Icons.add, color: Colors.black),
                        iconSize: 32.0,
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  // Danh sách sản phẩm
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                        mainAxisExtent: 260.h,
                      ),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        final product = controller.products[index];
                        return ProductItem(product: product);
                      },
                    ),
                  ),
                  10.verticalSpace,
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}