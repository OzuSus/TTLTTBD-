import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../controllers/product_details_controller.dart';
import 'widgets/rounded_button.dart';
import 'widgets/size_item.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
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
                      height: 450.h,
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
                          // RoundedButton(
                          //   onPressed: () {
                          //     // Logic yêu thích nếu cần
                          //   },
                          //   child: SvgPicture.asset(Constants.favOutlinedIcon),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),

                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    controller.product.name,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                10.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        '\$${controller.product.price}',
                        style: theme.textTheme.displayMedium,
                      ),
                      30.horizontalSpace,
                      const Icon(Icons.star, color: Color(0xFFFFC542)),
                      5.horizontalSpace,
                      Text(
                        controller.product.rating.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      5.horizontalSpace,
                      Text(
                        '(${controller.product.reviewCount})',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    controller.product.description,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomButton(
                    text: 'Add to Cart',
                    onPressed: () {
                      // Logic thêm vào giỏ hàng
                    },
                    disabled: controller.product.quantity <= 0,
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
