import 'dart:io';

import 'package:ecommerce_app/app/components/category_dropdown_selector.dart';
import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/app/components/quantity_selector_state.dart';
import 'package:ecommerce_app/app/models/category.dart';
import 'package:ecommerce_app/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:ecommerce_app/app/modules/product_manage/views/Edit_Product/controller/edit_product_controller.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../controller/create_product_controlller.dart';

class CreateProductView extends GetView<CreateProductController>{
  const CreateProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final TextEditingController _proNameController = TextEditingController();
    final TextEditingController _proPriController = TextEditingController();
    final TextEditingController _proDesController = TextEditingController();

    int quantity = 0;
    int? selectedCategoryId;

    void handleQuantityChange(int newQuantity) {
      quantity = newQuantity;
    }


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
                        // child: Obx((){
                        //   if(controller.selectedImage.value != null){
                        //     return Image.file(
                        //       File(controller.selectedImage.value!),
                        //       height: 400.h,
                        //       fit: BoxFit.cover,
                        //     );
                        //   }else{
                        //     return Image.asset(
                        //       'assets/images/product1.jpg', // Ảnh mặc định
                        //       fit: BoxFit.cover,
                        //       width: double.infinity,
                        //       height: 450.h,
                        //     );
                        //   }
                        //
                        // }),
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
                              controller.pickImage();
                            },
                            icon: const FaIcon(FontAwesomeIcons.image),
                            iconSize: 40.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    controller: _proNameController,
                    decoration: InputDecoration(
                      labelText: 'Tên sản phẩm',
                      labelStyle: const TextStyle(
                        color: Color(0xFF0FDA89),
                        fontSize: 16,
                      ),
                      hintText: 'Nhập tên sản phẩm',
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
                      QuantitySelector(quantity: quantity,onQuantityChanged: handleQuantityChange,),
                    ],
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        'Doanh mục sản phẩm :',
                        style: theme.textTheme.bodyMedium,
                      ),
                      CategoryDropdownSelector(categories: controller.categories,onCategorySelected: (int ? id){
                        selectedCategoryId =id;
                      }),
                    ],
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    controller: _proPriController,
                    decoration: InputDecoration(
                      labelText: 'Giá tiền',
                      labelStyle: const TextStyle(
                        color: Color(0xFF0FDA89),
                        fontSize: 16,
                      ),
                      hintText: 'Nhập giá sản phẩm',
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
                    keyboardType:const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}$')),
                    ],
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: TextField(
                    maxLines: 3, // Số dòng tối đa
                    controller: _proDesController,
                    decoration: InputDecoration(
                      labelText: 'Mô tả sản phẩm',
                      labelStyle: const TextStyle(
                        color: Color(0xFF0FDA89),
                        fontSize: 16,
                      ),
                      hintText: 'Nhập mô tả sản phẩm...',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0FDA89),
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
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomButton(
                    text: 'Tạo mới sản phẩm',
                    onPressed: () {
                      String name = _proNameController.text;
                      String price = _proPriController.text;
                      String des = _proDesController.text;

                      if (selectedCategoryId == null) {
                        Get.snackbar("Lỗi", "Vui lòng chọn danh mục sản phẩm!");
                        return;
                      }

                      controller.createProduct(name, price, des, quantity, selectedCategoryId.toString());
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