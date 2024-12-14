import 'package:ecommerce_app/app/components/product_item.dart';
import 'package:ecommerce_app/app/components/screen_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/productTypes_controller.dart';

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
            return const Center(child: Text('No products available'));
          }
          return ListView(
            children: [
              30.verticalSpace,
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