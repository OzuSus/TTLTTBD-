import 'package:ecommerce_app/app/models/product.dart';
import 'package:ecommerce_app/app/modules/base/controllers/base_controller.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.r),
                  child: Image.asset(
                    'assets/images/${product.image}',
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: GetBuilder<BaseController>(
                    id: 'FavoriteButton',
                    builder: (controller) => GestureDetector(
                      onTap: () {
                        // Gọi hàm xử lý yêu thích
                        // controller.onFavoriteButtonPressed(product.id);
                      },
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          Constants.favOutlinedIcon,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            10.verticalSpace,
            Text(
              product.name,
              style: theme.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
                .animate()
                .fade()
                .slideY(
              duration: const Duration(milliseconds: 200),
              begin: 1,
              curve: Curves.easeInSine,
            ),
            5.verticalSpace,
            Text('\$${product.price}', style: theme.textTheme.displaySmall)
                .animate()
                .fade()
                .slideY(
              duration: const Duration(milliseconds: 200),
              begin: 2,
              curve: Curves.easeInSine,
            ),
          ],
        ),
      ),
    );
  }
}
