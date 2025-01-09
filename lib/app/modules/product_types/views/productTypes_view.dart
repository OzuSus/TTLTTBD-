import 'package:ecommerce_app/app/components/no_data.dart';
import 'package:ecommerce_app/app/components/product_item.dart';
import 'package:ecommerce_app/app/components/screen_title.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../product_details/views/widgets/rounded_button.dart';
import '../controllers/productTypes_controller.dart';

import 'package:flutter_animate/flutter_animate.dart';


class ProducttypesView extends GetView<ProductTypesController> {
  const ProducttypesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {

          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.products.isEmpty) {
            return const NoData(text: "Doanh mục này chưa có sản phâm nào");
          }
          return ListView(
            children: [
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

                  ],
                ),
              ),
              10.verticalSpace,
              const ScreenTitle(
                title: 'Product Types',
                dividerEndIndent: 150,
              ),
              20.verticalSpace,
           
              GridView.builder(
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
              10.verticalSpace,
            ],
          );
        }),
      ),
    );
  }
}

// class CategoryForm extends StatelessWidget {
//   final ProductTypesController controller; // Thêm controller
//   const CategoryForm({Key? key, required this.controller}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100.h,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           final category = controller.categories[index];
//           return CategoryItem(
//             nameCategory: category.name,
//             imageName: category.image,
//             id: category.id,
//             // Tên ảnh từ API
//           ).animate().fade().slideY(
//             duration: const Duration(milliseconds: 300),
//             begin: 1,
//             curve: Curves.easeInSine,
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) => SizedBox(width: 10.w),
//         itemCount: controller.categories.length, // Số lượng item từ controller
//       ),
//     );
//   }
// }
//
//
// class CategoryItem extends StatelessWidget {
//   final String nameCategory;
//   final String imageName;
//   final int id;
//
//
//   const CategoryItem({
//     Key? key,
//     required this.nameCategory,
//     required this.imageName,
//     required this.id,
//   // Truyền hàm callback vào
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {}, // Gọi hàm callback khi click
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 30.r,
//             backgroundImage: AssetImage('assets/images/$imageName'),
//           ),
//           SizedBox(height: 5.h),
//           Text(
//             '$nameCategory',
//           ),
//         ],
//       ),
//     );
//   }
// }






