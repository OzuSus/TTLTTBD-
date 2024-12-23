import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/app/components/quantity_selector_state.dart';
import 'package:ecommerce_app/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:ecommerce_app/app/modules/product_manage/views/Edit_Product/controller/edit_product_controller.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProductView extends GetView<EditProductController>{
  const EditProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 400.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF1FA),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        ),
                        child: Image.asset(
                          'assets/images/${controller.product.image}',
                          fit: BoxFit.cover, // Đảm bảo ảnh lấp đầy container
                          width: double.infinity,
                          height: 450.h,
                        ),
                      ),
                    ),
                    // Nút quay lại và yêu thích
                    Positioned(
                      top: 30.h,
                      left: 20.w,
                      right: 20.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RoundedButton(
                            onPressed: () => Get.back(),
                            child: SvgPicture.asset(Constants.backArrowIcon),
                          ),
                          IconButton(
                            onPressed: () {

                            },
                            icon: FaIcon(FontAwesomeIcons.image),
                            iconSize: 40.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Tên sản phẩm',
                      labelStyle: const TextStyle(
                        color: Color(0xFF0FDA89),
                        fontSize: 16,
                      ),
                      hintText: controller.product.name,
                      hintStyle: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF0FDA89),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF0FDA89),
                          // Màu viền khi không được kích hoạt
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF0FDA89),
                          // Màu viền khi được kích hoạt
                          width: 2.0,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        'Số lượng :',
                        style: theme.textTheme.displayMedium,
                      ),
                      30.horizontalSpace,
                      QuantitySelector(),
                    ],
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Doanh mục sản phẩm :',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    maxLines: 5, // Số dòng tối đa
                    decoration: InputDecoration(
                      labelText: 'Mô tả sản phẩm',
                      labelStyle: const TextStyle(
                        color: Color(0xFF0FDA89),
                        fontSize: 16,
                      ),
                      hintText: 'Nhập mô tả sản phẩm...',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF0FDA89),
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF0FDA89),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Color(0xFF0FDA89),
                          width: 2.0,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomButton(
                    text: 'Lưu thay đổi',
                    onPressed: () {
                      // Logic thêm vào giỏ hàng
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}