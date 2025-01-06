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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.products.isEmpty) {
            return const Center(child: Text('No products available'));
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
                      onPressed: () => Get.offNamed(Routes.MANAGE),
                      child: SvgPicture.asset(Constants.backArrowIcon),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.PRODUCT_CREATE);
                      },
                      icon: FaIcon(FontAwesomeIcons.plus),
                      iconSize: 40.h,

                    ),

                  ],
                ),
              ),
              30.verticalSpace,
              const ScreenTitle(
                title: 'Product Manage',
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


